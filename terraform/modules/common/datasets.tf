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

resource "google_bigquery_dataset" "dbt_staging" {
  dataset_id    = "dbt_staging"
  friendly_name = "dbt staging"
  location      = var.location
  project       = var.project
}

resource "google_bigquery_dataset" "dbt_marts" {
  dataset_id    = "dbt_marts"
  friendly_name = "dbt marts"
  location      = var.location
  project       = var.project
}

resource "google_bigquery_dataset" "dbt_intermediate" {
  dataset_id    = "dbt_intermediate"
  friendly_name = "dbt intermediate"
  location      = var.location
  project       = var.project
}

resource "google_bigquery_dataset" "dbt_exposed" {
  dataset_id    = "dbt_exposed"
  friendly_name = "dbt exposed"
  location      = var.location
  project       = var.project
}

resource "google_bigquery_dataset" "dbt_access_controlled" {
  dataset_id    = "dbt_access_controlled"
  friendly_name = "dbt access controlled"
  location      = var.location
  project       = var.project
}

resource "google_bigquery_dataset" "tsm_data_analyses" {
  dataset_id    = "tsm_data_analyses"
  friendly_name = "tsm data analyses"
  location      = var.location
  project       = var.project
}

