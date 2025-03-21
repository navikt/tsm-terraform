data "google_secret_manager_secret_version" "sykmelding-bucket" {
  secret    = "sykmelding-bucket"
  version   = "latest"
}

data "google_secret_manager_secret_version" "tsm-sykmelding-bucket-upload-sa" {
  secret = "tsm-sykmelding-bucket-upload-sa"
  version = "latest"
}

resource "google_storage_bucket" "sykmelding-xml" {
  location = var.location
  name     = data.google_secret_manager_secret_version.sykmelding-bucket.secret_data

  uniform_bucket_level_access = true
  labels = {
    team = "tsm"
  }
}

resource "google_storage_bucket_iam_member" "sykmelding-upload-member" {
  bucket = google_storage_bucket.sykmelding-xml.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${data.google_secret_manager_secret_version.tsm-sykmelding-bucket-upload-sa.secret_data}"
}
