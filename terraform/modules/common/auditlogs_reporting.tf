resource "google_monitoring_notification_channel" "slack_notifikation" {
  display_name = "Log alerts to slack"
  type         = "slack"
  enabled = true
  labels = {
    channel_name = "#tsm-alert-spam"
    team = "NAV"
  }
  sensitive_labels {
    auth_token = var.slackbot_auth_token
  }
}

resource "google_monitoring_alert_policy" "audit_alert_policy" {
  display_name = "Audit log alert"
  combiner = "OR"
  depends_on = [
    google_monitoring_notification_channel.slack_notifikation
  ]
  documentation {
    mime_type = "text/markdown"
    content = <<-EOT
      **Cloud SQL data access (log-based alert)**
      - User: $${log.extracted_label.user}
      - Database: $${log.extracted_label.database}
      EOT
  }

  conditions {
    display_name = "Audit log"
    condition_matched_log {
      filter = <<-EOT
      logName=~".*cloudaudit.googleapis.com%2Fdata_access"
      resource.type="cloudsql_database"
      EOT
      label_extractors = {
        user          = "EXTRACT(protoPayload.request.user)"
        database      = "EXTRACT(protoPayload.request.database)"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.slack_notifikation.name
  ]

}
