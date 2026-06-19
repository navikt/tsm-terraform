variable "project" {
  default     = "tsm-dev-6602"
  type        = string
  description = "Project"
}

variable "region" {
  default     = "europe-north1"
  type        = string
  description = "Region"
}

variable "slackbot_auth_token" {
  type      = string
  sensitive = true
}

variable "slack_channel" {
  type    = string
  default = "#tsm-audit-log-dev"
}

variable "airflow_sa" {
  type    = string
  default = "team-symfoni-dev-5fe8@knada-dev.iam.gserviceaccount.com"
}
