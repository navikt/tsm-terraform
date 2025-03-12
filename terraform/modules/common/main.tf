resource "google_storage_bucket" "sykmelding-xml" {
  location = var.location
  name     = var.bucket-name

  uniform_bucket_level_access = true
}
