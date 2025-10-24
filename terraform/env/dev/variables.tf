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
