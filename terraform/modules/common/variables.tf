variable "location" {
  default = "europe-north1"
  type = string
}

variable "slackbot_auth_token" {
  type = string
  sensitive = true
}

variable "project" {
  type = string
}

variable "slack_channel" {
  type = string
}
