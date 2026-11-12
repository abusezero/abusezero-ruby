require 'json'
require 'net/http'
require 'openssl'
require 'base64'
require 'uri'
require 'time'
require 'timeout'
require 'thread'

module AbuseZero
  class Error < StandardError
    attr_reader :code, :status, :request_id, :retryable, :docs_url
    def initialize(code, message, status: 0, request_id: nil, retryable: false, docs_url: nil)
      super(message)
      @code, @status, @request_id, @retryable, @docs_url = code, status, request_id, retryable, docs_url
    end
  end
  class WebhookVerificationError < StandardError; end
  OPERATIONS = JSON.parse(File.read(File.join(__dir__, 'operations.json'), encoding: 'UTF-8')).freeze
  KEY = /\A(?:sk|rk)_[1-9][0-9]{19}\.[A-Za-z0-9_-]{43}\z/
  OPAQUE = /\A[\x21-\x7e]{1,128}\z/
  CREDENTIAL_HEADER = /\A(?:authorization|proxy-authorization|cookie|set-cookie|x-api-key|x-auth-token|x-csrf-token|x-xsrf-token)\z|(?:\A|-)(?:token|secret|session|password|api-key|apikey)(?:-|\z)/i

  def self.incoming_request(method:, url:, headers:)
    begin
      uri = URI.parse(url)
    rescue URI::InvalidURIError
      raise ArgumentError, 'Provide the incoming HTTP method and URL without credentials.', cause: nil
    end
    unless method.match?(/\A[A-Za-z]{1,16}\z/) && %w[http https].include?(uri.scheme) && uri.host && !uri.userinfo && url.length <= 4096
      raise ArgumentError, 'Provide the incoming HTTP method and URL without credentials.'
    end
    clean, size = {}, 0
    headers.each do |name, value|
      name = name.downcase
      next if CREDENTIAL_HEADER.match?(name) || !name.match?(/\A[!#$%&'*+.^_`|~0-9a-z-]{1,128}\z/) || !value.is_a?(String) || value.match?(/[\r\n]/)
      value = value[0, 8192]
      next if clean.size >= 64 || size + name.bytesize + value.bytesize > 32768
      clean[name] = value
      size += name.bytesize + value.bytesize
    end
    { 'method' => method, 'url' => url, 'headers' => clean }
  end

  def self.keyed_hash(secret, key_version, value)
    raise ArgumentError, 'Use a printable key version with no spaces.' unless key_version.match?(OPAQUE)
    { 'algorithm' => 'hmac-sha256', 'key_version' => key_version, 'value' => OpenSSL::HMAC.hexdigest('SHA256', secret, value) }
  end
  private_class_method :keyed_hash
  def self.create_phone_hash(secret:, key_version:, e164:)
    raise ArgumentError, 'Normalize the phone number to E.164 before hashing it.' unless e164.match?(/\A\+[1-9][0-9]{7,14}\z/)
    keyed_hash(secret, key_version, "abusezero:phone:e164:v1:#{e164}")
  end
  def self.create_custom_identifier(secret:, key_version:, key:, value:)
    raise ArgumentError, 'Provide a valid identifier key and nonempty value.' unless key.match?(/\A[a-z][a-z0-9_]{0,63}\z/) && !value.empty?
    { 'key' => key, 'value_hash' => keyed_hash(secret, key_version, "abusezero:custom:#{key}:v1:#{value}") }
  end
  def self.verify_webhook(payload:, headers:, secret:, tolerance_seconds: 300, now: Time.now.to_f)
    raise ArgumentError, 'Use a nonnegative timestamp tolerance.' unless tolerance_seconds.is_a?(Numeric) && tolerance_seconds.finite? && tolerance_seconds >= 0
    keys = Array(secret).compact.reject { |s| s.strip.empty? }.map do |s|
      raise ArgumentError, 'Provide the complete webhook signing secret.' unless s.strip.match?(/\Awhsk_[A-Za-z0-9+\/]{43}=\z/)
      Base64.strict_decode64(s.strip[5..])
    end
    raise ArgumentError, 'Provide a webhook signing secret.' if keys.empty?
    h = headers.transform_keys(&:downcase)
    id, timestamp, signatures = %w[id timestamp signature].map { |n| h["abusezero-webhook-#{n}"].to_s }
    unless !id.empty? && timestamp.match?(/\A[0-9]{1,12}\z/) && (now - timestamp.to_i).abs <= tolerance_seconds
      raise WebhookVerificationError, 'The webhook timestamp or headers are invalid.'
    end
    offered = signatures.split.filter_map { |s| Base64.strict_decode64(s[3..]) if s.start_with?('v1,') rescue nil }
    matches = keys.any? do |key|
      expected = OpenSSL::HMAC.digest('SHA256', key, "#{id}.#{timestamp}.".b + payload.b)
      offered.any? { |value| value.bytesize == expected.bytesize && OpenSSL.fixed_length_secure_compare(value, expected) }
    end
    raise WebhookVerificationError, 'The webhook signature does not match.' unless matches
    begin
      event = JSON.parse(payload)
      raise JSON::ParserError unless event.is_a?(Hash) && event['object'] == 'event' && event['id'] == id
      event
    rescue JSON::ParserError
      raise WebhookVerificationError, 'The webhook body is invalid.'
    end
  end

  def self.defaulted?(schema, root)
    schema = schema['$ref'].sub(%r{\A#/}, '').split('/').reduce(root) { |v, k| v.fetch(k.gsub('~1', '/').gsub('~0', '~')) } while schema.is_a?(Hash) && schema['$ref']
    schema.is_a?(Hash) && schema.key?('default')
  end
  private_class_method :defaulted?

  # A new kind of object within v1, such as a new lookup match kind: every variant fixes the same discriminator, the
  # value carries one none of them knows, and it keeps the shared object type. It passes through unchanged.
  def self.unknown_variant?(value, variants)
    return false unless value.is_a?(Hash) && variants.all? { |v| v['type'] == 'object' && v['properties'].is_a?(Hash) }
    fixed = ->(v) { v['properties'].select { |k, p| k != 'object' && p.is_a?(Hash) && p.key?('const') }.keys }
    keys = variants.map(&fixed).reduce(:&)
    types = variants.map { |v| v['properties'].dig('object', 'const') }.uniq
    keys.any? { |k| value[k].is_a?(String) && variants.none? { |v| v['properties'][k]['const'] == value[k] } } &&
      (types == [nil] || types.size == 1 && value['object'] == types.first)
  end
  private_class_method :unknown_variant?

  # Responses can gain new values for codes and enums within v1, so a response accepts an enum or fixed value it
  # doesn't know, except an object's own object type. Requests stay strict.
  def self.validate(value, schema, root = schema, response: false, field: nil)
    if schema['$ref']
      ref = schema['$ref'].sub(%r{\A#/}, '').split('/').reduce(root) { |v, k| v.fetch(k.gsub('~1', '/').gsub('~0', '~')) }
      return validate(value, ref, root, response: response, field: field)
    end
    variants = schema['anyOf'] || schema['oneOf']
    if variants
      count = variants.count { |v| validate(value, v, root, response: response, field: field) rescue false }
      return true if count.zero? && response && unknown_variant?(value, variants)
      raise ArgumentError, 'The value does not match the request schema.' if count.zero? || schema['oneOf'] && !response && count != 1
    end
    types = Array(schema['type'])
    matches = { 'null' => value.nil?, 'string' => value.is_a?(String), 'object' => value.is_a?(Hash), 'array' => value.is_a?(Array), 'integer' => value.is_a?(Integer), 'number' => value.is_a?(Numeric) && value.finite?, 'boolean' => [true, false].include?(value) }
    raise ArgumentError unless types.empty? || types.any? { |t| matches[t] }
    raise ArgumentError if schema.key?('const') && value != schema['const'] && (!response || field == 'object') || !response && schema['enum'] && !schema['enum'].include?(value)
    if value.is_a?(Hash)
      # A request may leave out a field the API fills with its default.
      required = Array(schema['required'])
      required = required.reject { |k| defaulted?(schema.fetch('properties', {})[k], root) } unless response
      raise ArgumentError if required.any? { |k| !value.key?(k) }
      value.each do |k, v|
        validate(k, schema['propertyNames'], root, response: response) if schema['propertyNames']
        child = schema.fetch('properties', {}).fetch(k, schema.fetch('additionalProperties', {}))
        raise ArgumentError if child == false
        validate(v, child, root, response: response, field: k) if child.is_a?(Hash)
      end
    elsif value.is_a?(Array)
      raise ArgumentError if value.size < schema.fetch('minItems', 0) || value.size > schema.fetch('maxItems', Float::INFINITY)
      value.each { |v| validate(v, schema.fetch('items', {}), root, response: response) }
    elsif value.is_a?(String)
      raise ArgumentError if value.length < schema.fetch('minLength', 0) || value.length > schema.fetch('maxLength', Float::INFINITY) || schema['pattern'] && !Regexp.new(schema['pattern']).match?(value)
    elsif value.is_a?(Numeric)
      raise ArgumentError if schema['multipleOf'] && (value.to_f / schema['multipleOf'] - (value.to_f / schema['multipleOf']).round).abs > 1e-9
      raise ArgumentError if value < schema.fetch('minimum', -Float::INFINITY) || value > schema.fetch('maximum', Float::INFINITY) || value <= schema.fetch('exclusiveMinimum', -Float::INFINITY) || value >= schema.fetch('exclusiveMaximum', Float::INFINITY)
    end
    true
  end

  class Core
    def initialize(key: nil, access_token: nil, workspace: nil, outage: 'throw', agent: nil, base_url: 'https://api.abusezero.com', transport: nil)
      @public = self.class::PUBLIC
      raise Error.new('CREDENTIAL_REQUIRED', 'Provide one server API key or OAuth access token.', status: 401) if !@public && (!!key == !!access_token)
      raise Error.new('INVALID_KEY', 'Provide a server API key.', status: 401) if key && !KEY.match?(key)
      raise Error.new('INVALID_TOKEN', 'Provide a valid OAuth access token.', status: 401) if access_token && !access_token.match?(/\A[\x21-\x7e]{1,8192}\z/)
      raise Error.new('WORKSPACE_REQUIRED', 'Provide the selected workspace.', status: 422) if access_token && !workspace
      raise ArgumentError, 'Provide the workspace ID.' if workspace && !workspace.match?(/\A[1-9][0-9]{19}\z/)
      raise ArgumentError, 'Set outage to throw, allow or deny.' unless %w[throw allow deny].include?(outage)
      begin
        uri = URI.parse(base_url)
      rescue URI::InvalidURIError
        raise ArgumentError, 'Use an HTTPS API origin, or HTTP on loopback for local testing.', cause: nil
      end
      unless uri.host && !uri.userinfo && !uri.query && !uri.fragment && ['', '/'].include?(uri.path) && (uri.scheme == 'https' || uri.scheme == 'http' && %w[localhost 127.0.0.1 ::1 [::1]].include?(uri.host))
        raise ArgumentError, 'Use an HTTPS API origin, or HTTP on loopback for local testing.'
      end
      @credential, @workspace, @outage, @key, @base, @transport = key || access_token, workspace, outage, !!key, base_url.sub(%r{/$}, ''), transport
      @agent = agent.to_s.gsub(/[^\x20-\x7e]/, '')[0, 512]
      @mutex = Mutex.new
      @http = Net::HTTP.new(uri.hostname, uri.port)
      @http.use_ssl = uri.scheme == 'https'
      @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      @http.max_retries = 0
      @http.keep_alive_timeout = 50
    end
    def inspect
      "#<#{self.class}>"
    end
    def close
      @mutex.synchronize { @http.finish if @http.started? }
    end
    private
    def call_operation(id, input, path, key)
      op = OPERATIONS.fetch(id)
      raise ArgumentError, 'Use the matching API client.' unless op['public'] == @public
      raise Error.new('OAUTH_REQUIRED', "This method needs an OAuth access token. An API key alone can't run it.", status: 403) if @key && op['scope'] == 'operations:management'
      raise Error.new('INVALID_IDEMPOTENCY_KEY', 'Provide an idempotency key of 1–128 printable characters with no spaces.', status: 422) if op['mutation'] && !key || key && !key.match?(OPAQUE)
      data = JSON.parse(JSON.generate(input))
      route = op['path'].dup
      path = path.transform_keys(&:to_s)
      unless path.keys.sort == op['paths'].map { |p| p['name'] }.sort
        raise ArgumentError, "Pass every path field this method needs, such as path: { 'id' => id }."
      end
      op['paths'].each do |p|
        value = path.fetch(p['name'])
        begin
          AbuseZero.validate(value, p['schema'])
        rescue ArgumentError, KeyError
          hint = p['schema']['pattern'] == '^[1-9][0-9]{19}$' ? ' IDs are 20-digit strings.' : ''
          raise ArgumentError, "Check path['#{p['name']}'].#{hint}", cause: nil
        end
        encoded = URI.encode_www_form_component(value.to_s).gsub('+', '%20')
        encoded = encoded.gsub('%2F', '/') if p['name'] == 'path'
        route.sub!("{#{p['name']}}", encoded)
      end
      data['context']['user_agent'] = data['context']['user_agent'][0, 512] if id.start_with?('evaluations.') && data.dig('context', 'user_agent').is_a?(String)
      if data['request'].is_a?(Hash)
        r = data['request']
        data['request'] = AbuseZero.incoming_request(method: r['method'], url: r['url'], headers: r['headers'])
      end
      begin
        AbuseZero.validate(data, op['input'])
      rescue ArgumentError, KeyError
        raise Error.new('INVALID_REQUEST', 'Check the request against the API schema.', status: 422)
      end
      body = nil
      if op['method'] == 'GET'
        query = URI.encode_www_form(data.map { |k, v| [k, v.is_a?(String) ? v : JSON.generate(v)] })
        route += '?' + query unless query.empty?
      else
        body = JSON.generate(data)
        raise Error.new('PAYLOAD_TOO_LARGE', 'The evaluation request is larger than 48 KiB.', status: 413) if id == 'evaluations.create' && body.bytesize > 49152
      end
      headers = { 'Accept' => 'application/json' }
      unless @public
        headers['Authorization'] = 'Bearer ' + @credential
        headers['AbuseZero-Workspace'] = @workspace if @workspace
        headers['AbuseZero-Agent'] = @agent unless @agent.empty?
      end
      headers['Content-Type'] = 'application/json' if body
      headers['Idempotency-Key'] = key if key
      budget = op['timeout_ms'] / 1000.0
      budget = [budget, data.fetch('wait', 0) + 5].max if id == 'events.list'
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + budget
      failure = nil
      rate_error = nil
      3.times do |attempt|
        remaining = deadline - Process.clock_gettime(Process::CLOCK_MONOTONIC)
        response = nil
        begin
          raise Timeout::Error if remaining <= 0
          response = Timeout.timeout(remaining, Timeout::Error) do
            if @transport
              @transport.call(op['method'], @base + route, headers, body, remaining)
            else
              @mutex.synchronize do
                begin
                  @http.open_timeout = @http.read_timeout = @http.write_timeout = remaining
                  @http.start unless @http.started?
                  request = Net::HTTPGenericRequest.new(op['method'], !body.nil?, true, route, headers)
                  request.body = body if body
                  @http.request(request)
                rescue Timeout::Error, IOError, SystemCallError, SocketError, OpenSSL::SSL::SSLError, Net::HTTPBadResponse
                  @http.finish if @http.started?
                  raise
                end
              end
            end
          end
          return read_response(op, response)
        rescue Error => e
          failure = e
          rate_error = e if e.status == 429
        rescue Timeout::Error
          failure = Error.new('DEADLINE_EXCEEDED', 'The request ran out of time.', retryable: true)
        rescue IOError, SystemCallError, SocketError, OpenSSL::SSL::SSLError, Net::HTTPBadResponse
          failure = Error.new('TRANSPORT_ERROR', "AbuseZero couldn't be reached, or the response didn't arrive complete.", retryable: true)
        end
        break unless failure.retryable && attempt < 2
        delay = [0.1, 0.25][attempt]
        if response && response['Retry-After']
          value = response['Retry-After']
          seconds = Float(value) rescue (Time.httpdate(value).to_f - Time.now.to_f rescue 0)
          delay = [delay, seconds].max
        end
        break if Process.clock_gettime(Process::CLOCK_MONOTONIC) + delay >= deadline
        sleep(delay)
      end
      failure = rate_error || failure
      if id == 'evaluations.create' && @outage != 'throw' && failure.retryable && failure.status != 429
        return { 'source' => 'local_outage', 'claim_id' => data['claim_id'], 'result' => @outage, 'error' => failure }
      end
      raise failure
    end
    def read_response(op, response)
      data = JSON.parse(response.body) rescue nil
      status = response.code.to_i
      if status.between?(200, 299)
        raise Error.new('INVALID_RESPONSE', 'AbuseZero returned an unreadable response.', status: 502, retryable: true) unless data.is_a?(Hash)
        if %w[evaluations.create evaluations.dry_run].include?(op['id'])
          if data['status'] == 'skipped' && data['reason'].is_a?(String) && data['reason'].match?(/\A[a-z][a-z0-9_]{0,63}\z/)
            data['source'] = 'abusezero' if op['id'] == 'evaluations.create'
            return data
          end
          risk = data['risk']
          valid = %w[allow deny].include?(data['result']) && risk.is_a?(Hash) && risk['band'].is_a?(String) && (risk['score'].nil? || risk['score'].is_a?(Numeric) && risk['score'].between?(0, 100))
          if op['id'] == 'evaluations.create'
            valid &&= data['object'] == 'evaluation' && data['id'].is_a?(String) && data['id'].match?(/\A[1-9][0-9]{19}\z/)
            reported = data['outcome']
            raise Error.new('INVALID_RESPONSE', 'AbuseZero returned an unreadable outcome.', status: 502, retryable: true) unless reported.nil? || reported.is_a?(Hash)
            state = reported&.fetch('state', nil) || response['AbuseZero-Outcome-State']
            raise Error.new('INVALID_RESPONSE', 'AbuseZero returned an unreadable outcome state.', status: 502, retryable: true) if state && !(state.is_a?(String) && state.match?(/\A[a-z][a-z0-9_]{0,63}\z/))
            data['outcome'] = state ? { 'state' => state, 'due_at' => reported&.fetch('due_at', nil) || response['AbuseZero-Outcome-Due-At'] } : nil
            data['source'] = 'abusezero'
          end
          valid &&= data['object'] == 'evaluation_dry_run' && data['dry_run'] == true if op['id'] == 'evaluations.dry_run'
          raise Error.new('INVALID_RESPONSE', 'AbuseZero returned an unreadable evaluation.', status: 502, retryable: true) unless valid
        end
        begin
          AbuseZero.validate(data, op['response'], response: true)
        rescue ArgumentError, KeyError
          raise Error.new('INVALID_RESPONSE', 'AbuseZero returned an unreadable response.', status: 502, retryable: true)
        end
        return data
      end
      detail = data.is_a?(Hash) && data['error'].is_a?(Hash) ? data['error'] : {}
      raise Error.new(detail.fetch('code', 'HTTP_ERROR'), detail.fetch('message', 'AbuseZero could not finish the request.'), status: status, request_id: response['X-Request-ID'], retryable: ![401, 403].include?(status) && !status.between?(300, 399) && ([429, 502, 503, 504].include?(status) || detail['retryable'] == true), docs_url: detail['docs_url'])
    end
  end
end
