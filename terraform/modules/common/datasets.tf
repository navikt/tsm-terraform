resource "google_bigquery_dataset" "tsm_dataset" {
  dataset_id    = "tsm_dataset"
  friendly_name = "tsm dataset"
  location      = var.location
  project       = var.project
}