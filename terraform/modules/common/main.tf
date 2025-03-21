data "google_secret_manager_secret_version" "sykmelding-bucket" {
  secret    = "sykmelding-bucket"
  version   = "latest"
}



resource "google_storage_bucket" "sykmelding-xml" {
  location = var.location
  name     = data.google_secret_manager_secret_version.sykmelding-bucket.secret_data

  uniform_bucket_level_access = true
  labels = {
    team = "tsm"
  }
}
