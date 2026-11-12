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
