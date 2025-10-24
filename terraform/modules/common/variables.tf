variable "location" {
  default = "europe-north1"
  type = string
}

variable "slackbot_auth_token" {
  type = string
  sensitive = true
}
