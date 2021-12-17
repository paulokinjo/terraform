# Condition for v1/authorize/redirect-url
# NRQL alert condition
resource "newrelic_nrql_alert_condition" "newsletter_nrac" {
  policy_id                    = newrelic_alert_policy.newsletter_ap.id
  type                         = "static"
  name                         = "[Percentage Latency]"
  description                  = "Alert when transactions are taking too long"
  enabled                      = true
  value_function               = "single_value"
  violation_time_limit_seconds = 604800
  fill_option                  = "none"
  aggregation_window           = 900
  aggregation_method           = "event_flow"
  aggregation_delay            = 1200

  nrql {
    query = "SELECT average(duration) FROM Transaction where appName = '${data.newrelic_entity.app_name.name}'"
  }

  critical {
    operator              = "below"
    threshold             = 99
    threshold_duration    = 900
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "below"
    threshold             = 99.4
    threshold_duration    = 900
    threshold_occurrences = "ALL"
  }
}