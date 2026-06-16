resource "google_service_account" "dbt_airflow" {
  account_id = "dbt-airflow"
}

resource "google_project_iam_member" "dbt_airflow_bq_job_user" {
  project = var.project
  role    = "roles/bigquery.jobUser"
  member  = google_service_account.dbt_airflow.member
}

resource "google_bigquery_dataset_iam_member" "dbt_airflow_tsm_dataset_access" {
  dataset_id = google_bigquery_dataset.tsm_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = google_service_account.dbt_airflow.member
}

resource "google_bigquery_dataset_iam_member" "dbt_airflow_staging_access" {
  dataset_id = "dbt_staging"
  role       = "roles/bigquery.dataEditor"
  member     = google_service_account.dbt_airflow.member
}

resource "google_bigquery_dataset_iam_member" "dbt_airflow_marts_access" {
  dataset_id = "dbt_marts"
  role       = "roles/bigquery.dataEditor"
  member     = google_service_account.dbt_airflow.member
}

resource "google_bigquery_dataset_iam_member" "dbt_airflow_intermediate_access" {
  dataset_id = "dbt_intermediate"
  role       = "roles/bigquery.dataEditor"
  member     = google_service_account.dbt_airflow.member
}

resource "google_bigquery_dataset_iam_member" "dbt_airflow_exposed_access" {
  dataset_id = "dbt_exposed"
  role       = "roles/bigquery.dataEditor"
  member     = google_service_account.dbt_airflow.member
}

resource "google_bigquery_dataset_iam_member" "dbt_airflow_access_controlled_access" {
  dataset_id = "dbt_access_controlled"
  role       = "roles/bigquery.dataEditor"
  member     = google_service_account.dbt_airflow.member
}

resource "google_service_account_iam_member" "dbt_airflow_token_creator" {
  service_account_id = google_service_account.dbt_airflow.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:team-symfoni-cfe8@knada-gcp.iam.gserviceaccount.com"
}
