# AbuseZero Ruby SDK

Use the AbuseZero Ruby SDK to evaluate claims and manage your workspace from your server. AbuseZero is an abuse prevention API for SaaS.

## Install

```bash
gem install abusezero
```

With Bundler, add it to your Gemfile:

```ruby
gem 'abusezero', '~> 0.1'
```

Supported runtimes: Ruby 3.3, 3.4 and 4.0. The gem's RBS type signatures, in `sig/`, need RBS 3.5 or later.

The package includes its SDK license as `LICENSE`. Dependencies retain their own licenses; see `THIRD-PARTY-NOTICES`.

## Evaluate and report a grant

Store your SECRET KEY or RESTRICTED KEY in `ABUSEZERO_SECRET_KEY` on the server. Use a stable claim ID and keep the same idempotency key when retrying the same action.

```ruby
require 'abusezero'

def create_client
  AbuseZero::Client.new(key: ENV.fetch('ABUSEZERO_SECRET_KEY'), outage: 'throw')
end

def evaluate_and_grant(client, claim_id:, email:)
  raise ArgumentError, 'Provide a grant block.' unless block_given?
  result = client.evaluate({
    'benefit' => 'pro_trial', 'claim_id' => claim_id,
    'subject' => { 'email' => email }
  }, idempotency_key: 'evaluate:' + claim_id)
  return result if result['status'] == 'skipped'
  return result if result['source'] == 'local_outage' || result['result'] != 'allow'
  yield claim_id # Your transaction must finish successfully before returning.
  client.outcome({ 'outcome' => 'granted' }, path: { 'id' => result['id'] },
                 idempotency_key: 'grant:' + claim_id)
  result
end
```

Create a client when your server starts, reuse it across requests and close it at shutdown. A client sends one request at a time, so in a multi-threaded server, create one client per thread. Call this helper from your authenticated handler with your own stored claim ID, authenticated user email and transactional grant block. The grant block must be idempotent for that claim ID. The helper reports `granted` only after the grant block succeeds; if reporting fails afterward, retry with the same claim ID and keys. On `deny`, don't grant the benefit. A skipped result is neither allow nor deny, including when its reason is new to your application.

## Credentials, public calls and webhooks

```ruby
public_client = AbuseZero::PublicClient.new
catalog = public_client.pricing
public_client.close

client = AbuseZero::Client.new(access_token: ENV.fetch('ABUSEZERO_ACCESS_TOKEN'),
  workspace: ENV.fetch('ABUSEZERO_WORKSPACE'), outage: 'throw')
page = client.api_keys({ 'limit' => 20 })
client.close

event = AbuseZero.verify_webhook(payload: raw_body, headers: headers,
  secret: [current_secret, previous_secret])
```

Catch `AbuseZero::Error`. Its fields are `code`, `status`, `request_id`, `retryable` and `docs_url`. `status` is `0` when no response arrived. Catch `AbuseZero::WebhookVerificationError` for invalid webhook signatures. If setup, helper or path input can't be used, such as a malformed URL, phone number or ID, the SDK raises `ArgumentError`. Other input that doesn't match the API raises `AbuseZero::Error` with `INVALID_REQUEST`.

For tests or proxies, pass a `transport:` callable receiving method, URL, headers, body bytes and remaining seconds. Return a response with `code`, `body` and header lookup through `[]`. The callable must respect the remaining budget and verify TLS.

Methods with the `operations:management` scope need an OAuth access token; an API key alone can't run them. They include creating, rolling and revoking API keys and machine clients, changing members and invitations, buying credits, changing the plan, paying invoices, managing payment methods, changing data retention and reading webhook signing secrets. `API.md` lists each method's scope. Reads such as listing API keys, members and invoices, and settings such as billing details, work with an API key that has their scope. The selected workspace and the approving member's permissions still apply. Public clients send no credentials.

Verify webhook signatures over the original request bytes before reading event data. Verification checks the timestamp within 300 seconds by default (`tolerance_seconds:`), accepts rotating secrets and rejects a modified body. Deduplicate accepted events by their event ID in your application.

## Retries and results

Set `outage` to `throw`, `allow` or `deny`. The default is `throw`. Only `evaluate` can return `source: local_outage`; `dry_run_evaluation` and every other method raise an error. Rate limits always remain errors. Skipped responses remain skips, including unknown skip reasons. Responses can gain new fields and new values. The SDK passes them through unchanged, so handle a value you don't recognize as a generic case.

Calls make at most three attempts. Network errors, retryable API errors and HTTP 429, 502, 503 and 504 may be retried. `Retry-After` sets the minimum wait. Every attempt uses identical serialized input and the same idempotency key. The entire call, including retry waits and any wait for its client, has one budget: 1.8 seconds for evaluation and 5 seconds for other calls. An `events` long poll adds 5 seconds to its requested wait, so give long polls a client of their own. The server's own operation deadline can be shorter.

## Methods and pagination

Every public server operation has a method. Pass query fields in the input object and path fields separately in `path`. Mutation methods require an idempotency key. See `API.md` in the package for the complete method map and the [AbuseZero REST API reference](https://docs.abusezero.com/docs/api-reference).

List methods accept `cursor` and `limit` where documented. Process the returned `data`, then pass the returned `next_cursor` to the same method until it is null. Keep IDs and cursors as strings. Send null only when the field allows it. A field you leave out isn't sent, and the API applies its default where it has one, so `update_benefit` resets any configuration field you leave out. Send every configuration field you aren't changing.

## Incoming requests and identifiers

```ruby
secret = ENV.fetch('IDENTIFIER_HASH_SECRET')
phone = AbuseZero.create_phone_hash(secret: secret, key_version: 'v1', e164: '+14155550123')
loyalty = AbuseZero.create_custom_identifier(secret: secret, key_version: 'v1', key: 'loyalty_id', value: 'L-4821')
incoming = AbuseZero.incoming_request(method: 'POST', url: 'https://example.com/signup',
  headers: { 'user-agent' => 'Mozilla/5.0' })

client.evaluate({
  'benefit' => 'pro_trial', 'claim_id' => claim_id, 'subject' => { 'email' => email },
  'identifiers' => { 'phone_hash' => phone, 'phone_verified' => true, 'custom' => [loyalty] },
  'request' => incoming
}, idempotency_key: 'evaluate:' + claim_id)
```

`incoming_request` takes the HTTP method, absolute URL and headers. It removes credential headers before returning the request object to include in an evaluation. It doesn't infer a trusted client IP; use your application's trusted proxy configuration for that.

`create_phone_hash` requires an E.164 phone number. `create_custom_identifier` requires the identifier's key and a nonempty value; register the key before you send it. Keep the hash secret and `key_version` consistent across applications that should recognize the same identifier. The helpers return the public API's hash objects.

## Frameworks and transport

Framework adapters are documented in `examples/frameworks.md`; no framework dependency is required. For browser protection, add the versioned script from AbuseZero to your page and pass its device token to your server. Send the token unchanged as `identifiers.device_token` in the evaluation input. If your consent tool keeps the script from loading, send `unavailable:not_loaded`. The Ruby SDK is the only package to install. See [Set up browser protection](https://docs.abusezero.com/docs/guides/set-up-browser-protection).

The default API origin is `https://api.abusezero.com`. Custom origins require HTTPS; HTTP is accepted only for explicit loopback testing. Built-in transports verify TLS and refuse redirects. Custom transports are responsible for equivalent behavior. Never log credentials or raw authenticated requests.

See [authentication](https://docs.abusezero.com/docs/api-reference/authentication), [evaluation results](https://docs.abusezero.com/docs/api-reference/evaluations#response), [skipped evaluations](https://docs.abusezero.com/docs/api-reference/evaluations#skipped-evaluations) and [webhooks](https://docs.abusezero.com/docs/guides/receive-webhooks).
