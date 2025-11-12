resource "google_bigquery_dataset" "tsm_dataset" {
  dataset_id    = "tsm_dataset"
  friendly_name = "tsm dataset"
  location      = var.location
  project       = var.project
}

resource "google_bigquery_table" "regulus_maximus" {
  dataset_id = google_bigquery_dataset.tsm_dataset.dataset_id
  table_id   = "regulus_maximus"
}

