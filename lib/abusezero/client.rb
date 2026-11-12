require_relative 'core'
module AbuseZero
  class Client < Core
    PUBLIC = false
    def workspaces(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspaces.list', input, path, idempotency_key)
    end
    def me(input = {}, path: {}, idempotency_key: nil)
      call_operation('me.get', input, path, idempotency_key)
    end
    def api_keys(input = {}, path: {}, idempotency_key: nil)
      call_operation('api-keys.list', input, path, idempotency_key)
    end
    def create_api_key(input = {}, path: {}, idempotency_key: nil)
      call_operation('api-keys.create', input, path, idempotency_key)
    end
    def update_api_key(input = {}, path: {}, idempotency_key: nil)
      call_operation('api-keys.update', input, path, idempotency_key)
    end
    def roll_api_key(input = {}, path: {}, idempotency_key: nil)
      call_operation('api-keys.roll', input, path, idempotency_key)
    end
    def show_api_key_replacement(input = {}, path: {}, idempotency_key: nil)
      call_operation('api-keys.replacement', input, path, idempotency_key)
    end
    def revoke_api_key(input = {}, path: {}, idempotency_key: nil)
      call_operation('api-keys.revoke', input, path, idempotency_key)
    end
    def machine_clients(input = {}, path: {}, idempotency_key: nil)
      call_operation('machine-clients.list', input, path, idempotency_key)
    end
    def create_machine_client(input = {}, path: {}, idempotency_key: nil)
      call_operation('machine-clients.create', input, path, idempotency_key)
    end
    def rotate_machine_client_secret(input = {}, path: {}, idempotency_key: nil)
      call_operation('machine-clients.rotate_secret', input, path, idempotency_key)
    end
    def revoke_machine_client(input = {}, path: {}, idempotency_key: nil)
      call_operation('machine-clients.revoke', input, path, idempotency_key)
    end
    def authorized_apps(input = {}, path: {}, idempotency_key: nil)
      call_operation('authorized-apps.list', input, path, idempotency_key)
    end
    def disconnect_authorized_app(input = {}, path: {}, idempotency_key: nil)
      call_operation('authorized-apps.disconnect', input, path, idempotency_key)
    end
    def members(input = {}, path: {}, idempotency_key: nil)
      call_operation('members.list', input, path, idempotency_key)
    end
    def update_member(input = {}, path: {}, idempotency_key: nil)
      call_operation('members.update', input, path, idempotency_key)
    end
    def remove_member(input = {}, path: {}, idempotency_key: nil)
      call_operation('members.remove', input, path, idempotency_key)
    end
    def invitations(input = {}, path: {}, idempotency_key: nil)
      call_operation('invitations.list', input, path, idempotency_key)
    end
    def invite_member(input = {}, path: {}, idempotency_key: nil)
      call_operation('invitations.create', input, path, idempotency_key)
    end
    def resend_invitation(input = {}, path: {}, idempotency_key: nil)
      call_operation('invitations.resend', input, path, idempotency_key)
    end
    def cancel_invitation(input = {}, path: {}, idempotency_key: nil)
      call_operation('invitations.cancel', input, path, idempotency_key)
    end
    def workspace_settings(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.get', input, path, idempotency_key)
    end
    def update_workspace_settings(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.update', input, path, idempotency_key)
    end
    def upload_workspace_icon(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.icon_upload', input, path, idempotency_key)
    end
    def remove_workspace_icon(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.icon_remove', input, path, idempotency_key)
    end
    def workspace_icon_upload(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.icon_upload_get', input, path, idempotency_key)
    end
    def set_data_retention(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.retention', input, path, idempotency_key)
    end
    def setup_progress(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.setup', input, path, idempotency_key)
    end
    def finish_setup(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.setup_finish', input, path, idempotency_key)
    end
    def dismiss_setup_guide(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.setup_dismiss', input, path, idempotency_key)
    end
    def leave_workspace(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace.leave', input, path, idempotency_key)
    end
    def evaluations(input = {}, path: {}, idempotency_key: nil)
      call_operation('evaluations.list', input, path, idempotency_key)
    end
    def evaluate(input = {}, path: {}, idempotency_key: nil)
      call_operation('evaluations.create', input, path, idempotency_key)
    end
    def evaluation_filters(input = {}, path: {}, idempotency_key: nil)
      call_operation('evaluations.filters', input, path, idempotency_key)
    end
    def get_evaluation(input = {}, path: {}, idempotency_key: nil)
      call_operation('evaluations.get', input, path, idempotency_key)
    end
    def evaluation_graph(input = {}, path: {}, idempotency_key: nil)
      call_operation('evaluations.graph', input, path, idempotency_key)
    end
    def evaluation_evidence(input = {}, path: {}, idempotency_key: nil)
      call_operation('evaluations.evidence', input, path, idempotency_key)
    end
    def outcomes(input = {}, path: {}, idempotency_key: nil)
      call_operation('outcomes.list', input, path, idempotency_key)
    end
    def get_outcome(input = {}, path: {}, idempotency_key: nil)
      call_operation('outcomes.get', input, path, idempotency_key)
    end
    def outcome(input = {}, path: {}, idempotency_key: nil)
      call_operation('outcomes.report', input, path, idempotency_key)
    end
    def dry_run_evaluation(input = {}, path: {}, idempotency_key: nil)
      call_operation('evaluations.dry_run', input, path, idempotency_key)
    end
    def simulate(input = {}, path: {}, idempotency_key: nil)
      call_operation('simulations.sequence', input, path, idempotency_key)
    end
    def replay(input = {}, path: {}, idempotency_key: nil)
      call_operation('simulations.replay', input, path, idempotency_key)
    end
    def benefits(input = {}, path: {}, idempotency_key: nil)
      call_operation('benefits.list', input, path, idempotency_key)
    end
    def create_benefit(input = {}, path: {}, idempotency_key: nil)
      call_operation('benefits.create', input, path, idempotency_key)
    end
    def get_benefit(input = {}, path: {}, idempotency_key: nil)
      call_operation('benefits.get', input, path, idempotency_key)
    end
    def update_benefit(input = {}, path: {}, idempotency_key: nil)
      call_operation('benefits.update', input, path, idempotency_key)
    end
    def delete_benefit(input = {}, path: {}, idempotency_key: nil)
      call_operation('benefits.delete', input, path, idempotency_key)
    end
    def policies(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.list', input, path, idempotency_key)
    end
    def create_policy(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.create', input, path, idempotency_key)
    end
    def get_policy(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.get', input, path, idempotency_key)
    end
    def update_policy(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.update', input, path, idempotency_key)
    end
    def delete_policy(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.delete', input, path, idempotency_key)
    end
    def duplicate_policy(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.duplicate', input, path, idempotency_key)
    end
    def policy_versions(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.versions', input, path, idempotency_key)
    end
    def get_policy_version(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.version', input, path, idempotency_key)
    end
    def policy_signals(input = {}, path: {}, idempotency_key: nil)
      call_operation('policies.signals', input, path, idempotency_key)
    end
    def access_lists(input = {}, path: {}, idempotency_key: nil)
      call_operation('access-lists.list', input, path, idempotency_key)
    end
    def add_access_list_entries(input = {}, path: {}, idempotency_key: nil)
      call_operation('access-lists.create', input, path, idempotency_key)
    end
    def get_access_list_entry(input = {}, path: {}, idempotency_key: nil)
      call_operation('access-lists.get', input, path, idempotency_key)
    end
    def delete_access_list_entry(input = {}, path: {}, idempotency_key: nil)
      call_operation('access-lists.delete', input, path, idempotency_key)
    end
    def update_access_list_entry(input = {}, path: {}, idempotency_key: nil)
      call_operation('access-lists.update', input, path, idempotency_key)
    end
    def look_up_identifier(input = {}, path: {}, idempotency_key: nil)
      call_operation('identifiers.lookup', input, path, idempotency_key)
    end
    def custom_identifiers(input = {}, path: {}, idempotency_key: nil)
      call_operation('custom-identifiers.list', input, path, idempotency_key)
    end
    def register_custom_identifier(input = {}, path: {}, idempotency_key: nil)
      call_operation('custom-identifiers.create', input, path, idempotency_key)
    end
    def get_custom_identifier(input = {}, path: {}, idempotency_key: nil)
      call_operation('custom-identifiers.get', input, path, idempotency_key)
    end
    def delete_custom_identifier(input = {}, path: {}, idempotency_key: nil)
      call_operation('custom-identifiers.delete', input, path, idempotency_key)
    end
    def imports(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.list', input, path, idempotency_key)
    end
    def import_claim_history(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.create', input, path, idempotency_key)
    end
    def create_csv_import(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.csv', input, path, idempotency_key)
    end
    def get_import(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.get', input, path, idempotency_key)
    end
    def list_import_problems(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.problems', input, path, idempotency_key)
    end
    def import_problems_download(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.problems_download', input, path, idempotency_key)
    end
    def confirm_import(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.confirm', input, path, idempotency_key)
    end
    def discard_import(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.discard', input, path, idempotency_key)
    end
    def fix_import_row(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.fix_row', input, path, idempotency_key)
    end
    def skip_import_row(input = {}, path: {}, idempotency_key: nil)
      call_operation('imports.skip_row', input, path, idempotency_key)
    end
    def exports(input = {}, path: {}, idempotency_key: nil)
      call_operation('exports.list', input, path, idempotency_key)
    end
    def request_export(input = {}, path: {}, idempotency_key: nil)
      call_operation('exports.create', input, path, idempotency_key)
    end
    def get_export(input = {}, path: {}, idempotency_key: nil)
      call_operation('exports.get', input, path, idempotency_key)
    end
    def export_download(input = {}, path: {}, idempotency_key: nil)
      call_operation('exports.download', input, path, idempotency_key)
    end
    def request_workspace_export(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace-exports.create', input, path, idempotency_key)
    end
    def workspace_export(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace-exports.status', input, path, idempotency_key)
    end
    def workspace_export_download(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace-exports.download', input, path, idempotency_key)
    end
    def delete_workspace_export(input = {}, path: {}, idempotency_key: nil)
      call_operation('workspace-exports.delete', input, path, idempotency_key)
    end
    def dry_run_data_deletion(input = {}, path: {}, idempotency_key: nil)
      call_operation('deletions.dry_run', input, path, idempotency_key)
    end
    def data_deletions(input = {}, path: {}, idempotency_key: nil)
      call_operation('deletions.list', input, path, idempotency_key)
    end
    def request_data_deletion(input = {}, path: {}, idempotency_key: nil)
      call_operation('deletions.create', input, path, idempotency_key)
    end
    def get_data_deletion(input = {}, path: {}, idempotency_key: nil)
      call_operation('deletions.get', input, path, idempotency_key)
    end
    def analytics(input = {}, path: {}, idempotency_key: nil)
      call_operation('analytics.list', input, path, idempotency_key)
    end
    def overview(input = {}, path: {}, idempotency_key: nil)
      call_operation('overview.get', input, path, idempotency_key)
    end
    def benefit_value(input = {}, path: {}, idempotency_key: nil)
      call_operation('analytics.value', input, path, idempotency_key)
    end
    def denial_reasons(input = {}, path: {}, idempotency_key: nil)
      call_operation('analytics.denial_reasons', input, path, idempotency_key)
    end
    def request_logs(input = {}, path: {}, idempotency_key: nil)
      call_operation('request-logs.list', input, path, idempotency_key)
    end
    def get_request_log(input = {}, path: {}, idempotency_key: nil)
      call_operation('request-logs.get', input, path, idempotency_key)
    end
    def audit_logs(input = {}, path: {}, idempotency_key: nil)
      call_operation('audit-logs.list', input, path, idempotency_key)
    end
    def get_audit_log(input = {}, path: {}, idempotency_key: nil)
      call_operation('audit-logs.get', input, path, idempotency_key)
    end
    def account_status(input = {}, path: {}, idempotency_key: nil)
      call_operation('account_status.get', input, path, idempotency_key)
    end
    def integration_status(input = {}, path: {}, idempotency_key: nil)
      call_operation('integration_status.get', input, path, idempotency_key)
    end
    def events(input = {}, path: {}, idempotency_key: nil)
      call_operation('events.list', input, path, idempotency_key)
    end
    def browser_collection(input = {}, path: {}, idempotency_key: nil)
      call_operation('browser_collection.get', input, path, idempotency_key)
    end
    def update_browser_collection(input = {}, path: {}, idempotency_key: nil)
      call_operation('browser_collection.update', input, path, idempotency_key)
    end
    def browser_script(input = {}, path: {}, idempotency_key: nil)
      call_operation('browser_collection.script', input, path, idempotency_key)
    end
    def webhook_endpoints(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.list', input, path, idempotency_key)
    end
    def create_webhook_endpoint(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.create', input, path, idempotency_key)
    end
    def get_webhook_endpoint(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.get', input, path, idempotency_key)
    end
    def update_webhook_endpoint(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.update', input, path, idempotency_key)
    end
    def delete_webhook_endpoint(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.delete', input, path, idempotency_key)
    end
    def send_webhook_test(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.test', input, path, idempotency_key)
    end
    def enable_webhook_endpoint(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.enable', input, path, idempotency_key)
    end
    def disable_webhook_endpoint(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.disable', input, path, idempotency_key)
    end
    def webhook_signing_secret(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.secret', input, path, idempotency_key)
    end
    def rotate_webhook_signing_secret(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-endpoints.rotate_secret', input, path, idempotency_key)
    end
    def webhook_usage(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-deliveries.usage', input, path, idempotency_key)
    end
    def webhook_deliveries(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-deliveries.list', input, path, idempotency_key)
    end
    def get_webhook_delivery(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-deliveries.get', input, path, idempotency_key)
    end
    def resend_webhook_delivery(input = {}, path: {}, idempotency_key: nil)
      call_operation('webhook-deliveries.resend', input, path, idempotency_key)
    end
    def plan(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.plan', input, path, idempotency_key)
    end
    def usage(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.usage', input, path, idempotency_key)
    end
    def credit_history(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.credit_history', input, path, idempotency_key)
    end
    def daily_usage(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.daily_usage', input, path, idempotency_key)
    end
    def enterprise_plans(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.enterprise_plans', input, path, idempotency_key)
    end
    def preview_enterprise_plan_code(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.codes.preview', input, path, idempotency_key)
    end
    def upcoming_charge(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.upcoming', input, path, idempotency_key)
    end
    def invoices(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.invoices', input, path, idempotency_key)
    end
    def payment_methods(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.payment_methods', input, path, idempotency_key)
    end
    def billing_details(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.details', input, path, idempotency_key)
    end
    def update_billing_details(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.details.update', input, path, idempotency_key)
    end
    def get_payment(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.payments.get', input, path, idempotency_key)
    end
    def quote_plan_change(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.quotes.create', input, path, idempotency_key)
    end
    def set_low_credit_alert(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.low_credit_alert.update', input, path, idempotency_key)
    end
    def choose_what_stays_active(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.over_limit.choose', input, path, idempotency_key)
    end
    def set_auto_reload(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.auto_reload.update', input, path, idempotency_key)
    end
    def buy_credits(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.credits.buy', input, path, idempotency_key)
    end
    def retry_credit_purchase(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.credits.retry', input, path, idempotency_key)
    end
    def confirm_plan_change(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.plan.change', input, path, idempotency_key)
    end
    def undo_scheduled_downgrade(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.downgrade.undo', input, path, idempotency_key)
    end
    def resume_subscription(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.subscription.resume', input, path, idempotency_key)
    end
    def pay_overdue_invoice(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.overdue.pay', input, path, idempotency_key)
    end
    def set_default_payment_method(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.payment_methods.default', input, path, idempotency_key)
    end
    def move_backup_payment_method(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.payment_methods.move', input, path, idempotency_key)
    end
    def remove_payment_method(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.payment_methods.remove', input, path, idempotency_key)
    end
    def redeem_enterprise_plan_code(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.codes.redeem', input, path, idempotency_key)
    end
    def create_billing_approval_link(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.approval_links.create', input, path, idempotency_key)
    end
    def billing_approval_link(input = {}, path: {}, idempotency_key: nil)
      call_operation('billing.approval_links.get', input, path, idempotency_key)
    end
    def update_account_name(input = {}, path: {}, idempotency_key: nil)
      call_operation('account.update', input, path, idempotency_key)
    end
    def email_preferences(input = {}, path: {}, idempotency_key: nil)
      call_operation('account.email_preferences', input, path, idempotency_key)
    end
    def update_email_preferences(input = {}, path: {}, idempotency_key: nil)
      call_operation('account.email_preferences_update', input, path, idempotency_key)
    end
    def notifications(input = {}, path: {}, idempotency_key: nil)
      call_operation('notifications.list', input, path, idempotency_key)
    end
    def mark_notification(input = {}, path: {}, idempotency_key: nil)
      call_operation('notifications.update', input, path, idempotency_key)
    end
    def mark_all_notifications_read(input = {}, path: {}, idempotency_key: nil)
      call_operation('notifications.read_all', input, path, idempotency_key)
    end
    def run_notification_action(input = {}, path: {}, idempotency_key: nil)
      call_operation('notifications.run_action', input, path, idempotency_key)
    end
    def contact_support(input = {}, path: {}, idempotency_key: nil)
      call_operation('support-tickets.create', input, path, idempotency_key)
    end
    def support_tickets(input = {}, path: {}, idempotency_key: nil)
      call_operation('support-tickets.list', input, path, idempotency_key)
    end
    def send_feedback(input = {}, path: {}, idempotency_key: nil)
      call_operation('feedback.create', input, path, idempotency_key)
    end
  end
  class PublicClient < Core
    PUBLIC = true
    def pricing(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.pricing', input, path, idempotency_key)
    end
    def price_quote(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.pricing_quote', input, path, idempotency_key)
    end
    def docs(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.docs', input, path, idempotency_key)
    end
    def search_docs(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.docs_search', input, path, idempotency_key)
    end
    def public_docs_page(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.docs_page', input, path, idempotency_key)
    end
    def help_articles(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.help', input, path, idempotency_key)
    end
    def search_help(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.help_search', input, path, idempotency_key)
    end
    def public_help_article(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.help_article', input, path, idempotency_key)
    end
    def openapi(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.openapi', input, path, idempotency_key)
    end
    def actions(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.actions', input, path, idempotency_key)
    end
    def error_codes(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.errors', input, path, idempotency_key)
    end
    def reason_codes(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.reasons', input, path, idempotency_key)
    end
    def webhook_event_types(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.webhook_events', input, path, idempotency_key)
    end
    def conditions(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.conditions', input, path, idempotency_key)
    end
    def glossary(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.glossary', input, path, idempotency_key)
    end
    def legal_documents(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.legal', input, path, idempotency_key)
    end
    def legal_document(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.legal_document', input, path, idempotency_key)
    end
    def changelog(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.changelog', input, path, idempotency_key)
    end
    def blog_posts(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.blog', input, path, idempotency_key)
    end
    def blog_post(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.blog_post', input, path, idempotency_key)
    end
    def versions(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.versions', input, path, idempotency_key)
    end
    def service_status(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.status', input, path, idempotency_key)
    end
    def contacts(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.contacts', input, path, idempotency_key)
    end
    def contact_sales(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.contact_sales', input, path, idempotency_key)
    end
    def contact_support(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.contact_support', input, path, idempotency_key)
    end
    def start_onboarding(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.onboarding_start', input, path, idempotency_key)
    end
    def onboarding_status(input = {}, path: {}, idempotency_key: nil)
      call_operation('public.onboarding_status', input, path, idempotency_key)
    end
  end
end
