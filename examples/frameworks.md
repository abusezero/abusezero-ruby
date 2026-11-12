# Ruby on Rails

A client sends one request at a time, so give each server thread its own `AbuseZero::Client`. Call it from the authenticated action that grants your benefit.

```ruby
client = Thread.current.thread_variable_get(:abusezero) ||
  Thread.current.thread_variable_set(:abusezero, AbuseZero::Client.new(key: ENV.fetch('ABUSEZERO_SECRET_KEY'), outage: 'throw'))
incoming = AbuseZero.incoming_request(method: request.request_method,
  url: request.original_url, headers: request.headers.to_h.filter_map { |key, value|
    next unless key.start_with?('HTTP_') && value.is_a?(String)
    [key.delete_prefix('HTTP_').tr('_', '-'), value]
  }.to_h)
result = client.evaluate({
  'benefit' => 'pro_trial', 'claim_id' => trial.id.to_s,
  'subject' => { 'email' => current_user.email }, 'request' => incoming
}, idempotency_key: "evaluate:#{trial.id}")
```

Use your own stored claim ID. Follow the README's result branches before granting the benefit. For webhooks, pass `request.raw_post` and the headers, built the same way as above, to `AbuseZero.verify_webhook`. Parse and act on the returned event only after verification succeeds.
