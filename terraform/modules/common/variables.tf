variable "location" {
  default = "europe-north1"
  type    = string
}

variable "slackbot_auth_token" {
  type      = string
  sensitive = true
}

variable "project" {
  type = string
}

variable "slack_channel" {
  type = string
}

variable "airflow_sa" {
  type        = string
  description = "Email of the Airflow service account allowed to impersonate the dbt-airflow service account"
}
