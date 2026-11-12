# API methods

Pass input fields in the method's input and path fields separately in `path`. Public methods belong to `AbuseZero::PublicClient` and need no credentials. All other methods belong to `AbuseZero::Client`. Methods with the `operations:management` scope need an OAuth access token; an API key alone can't call them.

| Method | HTTP operation | Path fields | Idempotency key | Scope |
|---|---|---|---|---|
| `pricing()` | `GET /v1/public/pricing` | — | — | Public, no credentials |
| `price_quote()` | `GET /v1/public/pricing/quote` | — | — | Public, no credentials |
| `docs()` | `GET /v1/public/docs` | — | — | Public, no credentials |
| `search_docs()` | `GET /v1/public/docs/search` | — | — | Public, no credentials |
| `public_docs_page()` | `GET /v1/public/docs/{path}` | path | — | Public, no credentials |
| `help_articles()` | `GET /v1/public/help` | — | — | Public, no credentials |
| `search_help()` | `GET /v1/public/help/search` | — | — | Public, no credentials |
| `public_help_article()` | `GET /v1/public/help/{path}` | path | — | Public, no credentials |
| `openapi()` | `GET /v1/public/openapi` | — | — | Public, no credentials |
| `actions()` | `GET /v1/public/actions` | — | — | Public, no credentials |
| `error_codes()` | `GET /v1/public/errors` | — | — | Public, no credentials |
| `reason_codes()` | `GET /v1/public/reasons` | — | — | Public, no credentials |
| `webhook_event_types()` | `GET /v1/public/webhook-events` | — | — | Public, no credentials |
| `conditions()` | `GET /v1/public/conditions` | — | — | Public, no credentials |
| `glossary()` | `GET /v1/public/glossary` | — | — | Public, no credentials |
| `legal_documents()` | `GET /v1/public/legal` | — | — | Public, no credentials |
| `legal_document()` | `GET /v1/public/legal/{document}` | document | — | Public, no credentials |
| `changelog()` | `GET /v1/public/changelog` | — | — | Public, no credentials |
| `blog_posts()` | `GET /v1/public/blog` | — | — | Public, no credentials |
| `blog_post()` | `GET /v1/public/blog/{slug}` | slug | — | Public, no credentials |
| `versions()` | `GET /v1/public/versions` | — | — | Public, no credentials |
| `service_status()` | `GET /v1/public/status` | — | — | Public, no credentials |
| `contacts()` | `GET /v1/public/contacts` | — | — | Public, no credentials |
| `contact_sales()` | `POST /v1/public/contact/sales` | — | Required | Public, no credentials |
| `contact_support()` | `POST /v1/public/contact/support` | — | Required | Public, no credentials |
| `start_onboarding()` | `POST /v1/public/onboarding-sessions` | — | — | Public, no credentials |
| `onboarding_status()` | `POST /v1/public/onboarding-sessions/{id}/status` | id | — | Public, no credentials |
| `workspaces()` | `GET /v1/workspaces` | — | — | `operations:general` |
| `me()` | `GET /v1/me` | — | — | `operations:general` |
| `api_keys()` | `GET /v1/api-keys` | — | — | `operations:general` |
| `create_api_key()` | `POST /v1/api-keys` | — | Required | `operations:management` |
| `update_api_key()` | `PATCH /v1/api-keys/{id}` | id | Required | `operations:management` |
| `roll_api_key()` | `POST /v1/api-keys/{id}/roll` | id | Required | `operations:management` |
| `show_api_key_replacement()` | `POST /v1/api-keys/{id}/replacement` | id | Required | `operations:management` |
| `revoke_api_key()` | `POST /v1/api-keys/{id}/revoke` | id | Required | `operations:management` |
| `machine_clients()` | `GET /v1/machine-clients` | — | — | `operations:general` |
| `create_machine_client()` | `POST /v1/machine-clients` | — | Required | `operations:management` |
| `rotate_machine_client_secret()` | `POST /v1/machine-clients/{id}/rotate-secret` | id | Required | `operations:management` |
| `revoke_machine_client()` | `POST /v1/machine-clients/{id}/revoke` | id | Required | `operations:management` |
| `authorized_apps()` | `GET /v1/authorized-apps` | — | — | `operations:general` |
| `disconnect_authorized_app()` | `POST /v1/authorized-apps/{id}/disconnect` | id | Required | `operations:management` |
| `members()` | `GET /v1/members` | — | — | `operations:general` |
| `update_member()` | `PATCH /v1/members/{id}` | id | Required | `operations:management` |
| `remove_member()` | `DELETE /v1/members/{id}` | id | Required | `operations:management` |
| `invitations()` | `GET /v1/invitations` | — | — | `operations:general` |
| `invite_member()` | `POST /v1/invitations` | — | Required | `operations:management` |
| `resend_invitation()` | `POST /v1/invitations/{id}/resend` | id | Required | `operations:management` |
| `cancel_invitation()` | `POST /v1/invitations/{id}/cancel` | id | Required | `operations:management` |
| `workspace_settings()` | `GET /v1/workspace` | — | — | `operations:general` |
| `update_workspace_settings()` | `PATCH /v1/workspace` | — | Required | `operations:configuration` |
| `upload_workspace_icon()` | `PUT /v1/workspace/icon` | — | Required | `operations:configuration` |
| `remove_workspace_icon()` | `DELETE /v1/workspace/icon` | — | Required | `operations:configuration` |
| `workspace_icon_upload()` | `GET /v1/workspace/icon/uploads/{id}` | id | — | `operations:general` |
| `set_data_retention()` | `PUT /v1/workspace/data-retention` | — | Required | `operations:management` |
| `setup_progress()` | `GET /v1/workspace/setup` | — | — | `operations:general` |
| `finish_setup()` | `POST /v1/workspace/setup/finish` | — | Required | `operations:general` |
| `dismiss_setup_guide()` | `POST /v1/workspace/setup/dismiss` | — | Required | `operations:general` |
| `leave_workspace()` | `POST /v1/workspace/leave` | — | Required | `operations:general` |
| `evaluations()` | `GET /v1/evaluations` | — | — | `operations:general` |
| `evaluate()` | `POST /v1/evaluations` | — | Required | `operations:general` |
| `evaluation_filters()` | `GET /v1/evaluation-filters` | — | — | `operations:general` |
| `get_evaluation()` | `GET /v1/evaluations/{id}` | id | — | `operations:general` |
| `evaluation_graph()` | `GET /v1/evaluations/{id}/graph` | id | — | `operations:general` |
| `evaluation_evidence()` | `GET /v1/evaluations/{id}/evidence` | id | — | `operations:general` |
| `outcomes()` | `GET /v1/outcomes` | — | — | `operations:general` |
| `get_outcome()` | `GET /v1/outcomes/{id}` | id | — | `operations:general` |
| `outcome()` | `POST /v1/evaluations/{id}/outcome` | id | Required | `operations:general` |
| `dry_run_evaluation()` | `POST /v1/evaluations/dry-run` | — | Required | `operations:general` |
| `simulate()` | `POST /v1/simulations` | — | — | `operations:general` |
| `replay()` | `POST /v1/replays` | — | — | `operations:general` |
| `benefits()` | `GET /v1/benefits` | — | — | `operations:general` |
| `create_benefit()` | `POST /v1/benefits` | — | Required | `operations:configuration` |
| `get_benefit()` | `GET /v1/benefits/{id}` | id | — | `operations:general` |
| `update_benefit()` | `PATCH /v1/benefits/{id}` | id | Required | `operations:configuration` |
| `delete_benefit()` | `DELETE /v1/benefits/{id}` | id | Required | `operations:configuration` |
| `policies()` | `GET /v1/policies` | — | — | `operations:general` |
| `create_policy()` | `POST /v1/policies` | — | Required | `operations:configuration` |
| `get_policy()` | `GET /v1/policies/{id}` | id | — | `operations:general` |
| `update_policy()` | `PATCH /v1/policies/{id}` | id | Required | `operations:configuration` |
| `delete_policy()` | `DELETE /v1/policies/{id}` | id | Required | `operations:configuration` |
| `duplicate_policy()` | `POST /v1/policies/{id}/duplicate` | id | Required | `operations:configuration` |
| `policy_versions()` | `GET /v1/policies/{id}/versions` | id | — | `operations:general` |
| `get_policy_version()` | `GET /v1/policies/{id}/versions/{version}` | id, version | — | `operations:general` |
| `policy_signals()` | `GET /v1/policy-signals` | — | — | `operations:general` |
| `access_lists()` | `GET /v1/access-lists` | — | — | `operations:general` |
| `add_access_list_entries()` | `POST /v1/access-lists` | — | Required | `operations:configuration` |
| `get_access_list_entry()` | `GET /v1/access-lists/{id}` | id | — | `operations:general` |
| `delete_access_list_entry()` | `DELETE /v1/access-lists/{id}` | id | Required | `operations:configuration` |
| `update_access_list_entry()` | `PATCH /v1/access-lists/{id}` | id | Required | `operations:configuration` |
| `look_up_identifier()` | `POST /v1/identifiers/lookup` | — | — | `operations:general` |
| `custom_identifiers()` | `GET /v1/custom-identifiers` | — | — | `operations:general` |
| `register_custom_identifier()` | `POST /v1/custom-identifiers` | — | Required | `operations:configuration` |
| `get_custom_identifier()` | `GET /v1/custom-identifiers/{id}` | id | — | `operations:general` |
| `delete_custom_identifier()` | `DELETE /v1/custom-identifiers/{id}` | id | Required | `operations:configuration` |
| `imports()` | `GET /v1/imports` | — | — | `operations:general` |
| `import_claim_history()` | `POST /v1/imports` | — | Required | `operations:general` |
| `create_csv_import()` | `POST /v1/imports/csv` | — | Required | `operations:general` |
| `get_import()` | `GET /v1/imports/{id}` | id | — | `operations:general` |
| `list_import_problems()` | `GET /v1/imports/{id}/problems` | id | — | `operations:general` |
| `import_problems_download()` | `GET /v1/imports/{id}/problems/download` | id | — | `operations:general` |
| `confirm_import()` | `POST /v1/imports/{id}/confirm` | id | Required | `operations:general` |
| `discard_import()` | `POST /v1/imports/{id}/discard` | id | Required | `operations:general` |
| `fix_import_row()` | `POST /v1/imports/{id}/fix` | id | Required | `operations:general` |
| `skip_import_row()` | `POST /v1/imports/{id}/skip` | id | Required | `operations:general` |
| `exports()` | `GET /v1/exports` | — | — | `operations:general` |
| `request_export()` | `POST /v1/exports` | — | Required | `operations:general` |
| `get_export()` | `GET /v1/exports/{id}` | id | — | `operations:general` |
| `export_download()` | `GET /v1/exports/{id}/download` | id | — | `operations:general` |
| `request_workspace_export()` | `POST /v1/workspace-exports` | — | Required | `operations:general` |
| `workspace_export()` | `GET /v1/workspace-exports` | — | — | `operations:general` |
| `workspace_export_download()` | `GET /v1/workspace-exports/{id}/download` | id | — | `operations:general` |
| `delete_workspace_export()` | `DELETE /v1/workspace-exports/{id}` | id | Required | `operations:general` |
| `dry_run_data_deletion()` | `POST /v1/data-deletions/dry-run` | — | — | `operations:general` |
| `data_deletions()` | `GET /v1/data-deletions` | — | — | `operations:general` |
| `request_data_deletion()` | `POST /v1/data-deletions` | — | Required | `operations:general` |
| `get_data_deletion()` | `GET /v1/data-deletions/{id}` | id | — | `operations:general` |
| `analytics()` | `GET /v1/analytics` | — | — | `operations:general` |
| `overview()` | `GET /v1/overview` | — | — | `operations:general` |
| `benefit_value()` | `GET /v1/analytics/value` | — | — | `operations:general` |
| `denial_reasons()` | `GET /v1/analytics/denial-reasons` | — | — | `operations:general` |
| `request_logs()` | `GET /v1/request-logs` | — | — | `operations:general` |
| `get_request_log()` | `GET /v1/request-logs/{id}` | id | — | `operations:general` |
| `audit_logs()` | `GET /v1/audit-logs` | — | — | `operations:general` |
| `get_audit_log()` | `GET /v1/audit-logs/{id}` | id | — | `operations:general` |
| `account_status()` | `GET /v1/account-status` | — | — | `operations:general` |
| `integration_status()` | `GET /v1/integration-status` | — | — | `operations:general` |
| `events()` | `GET /v1/events` | — | — | `operations:general` |
| `browser_collection()` | `GET /v1/browser-collection` | — | — | `operations:general` |
| `update_browser_collection()` | `PATCH /v1/browser-collection` | — | Required | `operations:configuration` |
| `browser_script()` | `GET /v1/browser-collection/script` | — | — | `operations:general` |
| `webhook_endpoints()` | `GET /v1/webhook-endpoints` | — | — | `operations:general` |
| `create_webhook_endpoint()` | `POST /v1/webhook-endpoints` | — | Required | `operations:configuration` |
| `get_webhook_endpoint()` | `GET /v1/webhook-endpoints/{id}` | id | — | `operations:general` |
| `update_webhook_endpoint()` | `PATCH /v1/webhook-endpoints/{id}` | id | Required | `operations:configuration` |
| `delete_webhook_endpoint()` | `DELETE /v1/webhook-endpoints/{id}` | id | Required | `operations:configuration` |
| `send_webhook_test()` | `POST /v1/webhook-endpoints/{id}/test` | id | Required | `operations:general` |
| `enable_webhook_endpoint()` | `POST /v1/webhook-endpoints/{id}/enable` | id | Required | `operations:configuration` |
| `disable_webhook_endpoint()` | `POST /v1/webhook-endpoints/{id}/disable` | id | Required | `operations:configuration` |
| `webhook_signing_secret()` | `GET /v1/webhook-endpoints/{id}/secret` | id | — | `operations:management` |
| `rotate_webhook_signing_secret()` | `POST /v1/webhook-endpoints/{id}/rotate-secret` | id | Required | `operations:management` |
| `webhook_usage()` | `GET /v1/webhook-usage` | — | — | `operations:general` |
| `webhook_deliveries()` | `GET /v1/webhook-deliveries` | — | — | `operations:general` |
| `get_webhook_delivery()` | `GET /v1/webhook-deliveries/{id}` | id | — | `operations:general` |
| `resend_webhook_delivery()` | `POST /v1/webhook-deliveries/{id}/resend` | id | Required | `operations:general` |
| `plan()` | `GET /v1/billing/plan` | — | — | `operations:general` |
| `usage()` | `GET /v1/billing/usage` | — | — | `operations:general` |
| `credit_history()` | `GET /v1/billing/credit-history` | — | — | `operations:general` |
| `daily_usage()` | `GET /v1/billing/daily-usage` | — | — | `operations:general` |
| `enterprise_plans()` | `GET /v1/billing/enterprise-plans` | — | — | `operations:general` |
| `preview_enterprise_plan_code()` | `POST /v1/billing/enterprise-plan-codes/preview` | — | — | `operations:general` |
| `upcoming_charge()` | `GET /v1/billing/upcoming-charge` | — | — | `operations:general` |
| `invoices()` | `GET /v1/billing/invoices` | — | — | `operations:general` |
| `payment_methods()` | `GET /v1/billing/payment-methods` | — | — | `operations:general` |
| `billing_details()` | `GET /v1/billing/details` | — | — | `operations:general` |
| `update_billing_details()` | `PUT /v1/billing/details` | — | Required | `operations:configuration` |
| `get_payment()` | `GET /v1/billing/payments/{id}` | id | — | `operations:general` |
| `quote_plan_change()` | `POST /v1/billing/quotes` | — | — | `operations:general` |
| `set_low_credit_alert()` | `PUT /v1/billing/low-credit-alert` | — | Required | `operations:configuration` |
| `choose_what_stays_active()` | `POST /v1/billing/over-limit` | — | Required | `operations:configuration` |
| `set_auto_reload()` | `PUT /v1/billing/auto-reload` | — | Required | `operations:management` |
| `buy_credits()` | `POST /v1/billing/credit-purchases` | — | Required | `operations:management` |
| `retry_credit_purchase()` | `POST /v1/billing/credit-purchases/{id}/retry` | id | Required | `operations:management` |
| `confirm_plan_change()` | `POST /v1/billing/quotes/{id}/confirm` | id | Required | `operations:management` |
| `undo_scheduled_downgrade()` | `POST /v1/billing/scheduled-change/undo` | — | Required | `operations:management` |
| `resume_subscription()` | `POST /v1/billing/subscription/resume` | — | Required | `operations:management` |
| `pay_overdue_invoice()` | `POST /v1/billing/invoices/pay` | — | Required | `operations:management` |
| `set_default_payment_method()` | `POST /v1/billing/payment-methods/{id}/default` | id | Required | `operations:management` |
| `move_backup_payment_method()` | `POST /v1/billing/payment-methods/{id}/move` | id | Required | `operations:management` |
| `remove_payment_method()` | `DELETE /v1/billing/payment-methods/{id}` | id | Required | `operations:management` |
| `redeem_enterprise_plan_code()` | `POST /v1/billing/enterprise-plan-codes/redeem` | — | Required | `operations:management` |
| `create_billing_approval_link()` | `POST /v1/billing/approval-links` | — | Required | `operations:management` |
| `billing_approval_link()` | `GET /v1/billing/approval-links/{id}` | id | — | `operations:general` |
| `update_account_name()` | `PATCH /v1/account` | — | Required | `operations:general` |
| `email_preferences()` | `GET /v1/account/email-preferences` | — | — | `operations:general` |
| `update_email_preferences()` | `PATCH /v1/account/email-preferences` | — | Required | `operations:configuration` |
| `notifications()` | `GET /v1/notifications` | — | — | `operations:general` |
| `mark_notification()` | `PATCH /v1/notifications/{id}` | id | Required | `operations:general` |
| `mark_all_notifications_read()` | `POST /v1/notifications/read-all` | — | Required | `operations:general` |
| `run_notification_action()` | `POST /v1/notifications/{id}/run` | id | Required | `operations:general` |
| `contact_support()` | `POST /v1/support-tickets` | — | Required | `operations:general` |
| `support_tickets()` | `GET /v1/support-tickets` | — | — | `operations:general` |
| `send_feedback()` | `POST /v1/feedback` | — | Required | `operations:general` |
