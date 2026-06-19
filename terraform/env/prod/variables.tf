variable "project" {
  default     = "tsm-prod-1dab"
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
  default = "#tsm-audit-log"
}

variable "airflow_sa" {
  type    = string
  default = "team-symfoni-cfe8@knada-gcp.iam.gserviceaccount.com"
}
