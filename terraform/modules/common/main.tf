data "google_secret_manager_secret_version" "sykmelding-bucket" {
  secret  = "sykmelding-bucket"
  version = "latest"
}

data "google_secret_manager_secret_version" "tsm-sykmelding-bucket-upload-sa" {
  secret  = "tsm-sykmelding-bucket-upload-sa"
  version = "latest"
}

data "google_secret_manager_secret_version" "journey-sa" {
  secret  = "journey-sa"
  version = "latest"
}

data "google_secret_manager_secret_version" "syfosmmottak-sa" {
  secret  = "syfosmmottak-sa"
  version = "latest"
}

data "google_secret_manager_secret_version" "ocr-bucket" {
  secret  = "ocr-bucket"
  version = "latest"
}

data "google_secret_manager_secret_version" "syfosmpapirmottak-sa" {
  secret  = "syfosmpapirmottak-sa"
  version = "latest"
}

resource "google_storage_bucket" "sykmelding-xml" {
  location = var.location
  name     = data.google_secret_manager_secret_version.sykmelding-bucket.secret_data

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
  labels = {
    team = "tsm"
  }
}

resource "google_storage_bucket" "ocr-bucket" {
  location = var.location
  name     = data.google_secret_manager_secret_version.ocr-bucket.secret_data

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
  labels = {
    team = "tsm"
  }
}

data "google_iam_policy" "sykmelding-xml-policy" {
  binding {
    role = "roles/storage.objectAdmin"
    members = [
      "serviceAccount:${data.google_secret_manager_secret_version.tsm-sykmelding-bucket-upload-sa.secret_data}",
      "serviceAccount:${data.google_secret_manager_secret_version.journey-sa.secret_data}",
      "serviceAccount:${data.google_secret_manager_secret_version.syfosmmottak-sa.secret_data}",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "sykmelding-xml-bucket-policy" {
  bucket      = google_storage_bucket.sykmelding-xml.name
  policy_data = data.google_iam_policy.sykmelding-xml-policy.policy_data
}

data "google_iam_policy" "ocr-bucket-policy" {
  binding {
    role    = "roles/storage.objectAdmin"
    members = ["serviceAccount:${data.google_secret_manager_secret_version.syfosmpapirmottak-sa.secret_data}"]
  }
}

resource "google_storage_bucket_iam_policy" "ocr-bucket-policy" {
  bucket      = google_storage_bucket.ocr-bucket.name
  policy_data = data.google_iam_policy.ocr-bucket-policy.policy_data
}
