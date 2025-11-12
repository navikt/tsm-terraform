resource "google_project_service" "iam" {
  project            = var.project
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "random_password" "bigquery_db_password" {
  length  = 16
  special = false
}

resource "google_sql_user" "bigquery_db_user" {
  name     = "bigquery-db-user"
  instance = "regulus-maximus-instance"
  password = random_password.bigquery_db_password.result
}

data "google_sql_database_instance" "regulus_maximus" {
  name = "regulus-maximus-instance"
}

resource "google_bigquery_connection" "regulus_maximus" {
  location      = var.location
  connection_id = "regulus-maximum-connection"
  friendly_name = "regulus maximus connection"
  description   = "Connetion to regulus maximus"
  cloud_sql {
    instance_id = data.google_sql_database_instance.regulus_maximus.connection_name
    database    = "regulus-maximus"
    type        = "POSTGRES"
    credential {
      username = google_sql_user.bigquery_db_user.name
      password = google_sql_user.bigquery_db_user.password
    }
  }
}

resource "google_project_iam_member" "bigquery_regulus_maximus" {
  project = var.project
  role    = "roles/bigquery.connectionAdmin"
  member  = "serviceAccount:${google_bigquery_connection.regulus_maximus.cloud_sql[0].service_account_id}"
}

resource "google_project_iam_member" "cloudsql_regulus_maximus" {
  project = var.project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_bigquery_connection.regulus_maximus.cloud_sql[0].service_account_id}"
}


resource "google_service_account" "federated-query" {
  account_id = "bq-federated-query"
}

resource "google_project_iam_member" "bq-connection" {
  project = var.project
  role    = "roles/bigquery.connectionUser"
  member  = google_service_account.federated-query.member
}


resource "google_project_iam_member" "bq-job" {
  project = var.project
  role    = "roles/bigquery.jobUser"
  member  = google_service_account.federated-query.member
}


resource "google_project_iam_member" "bq-metadata" {
  project = var.project
  role    = "roles/bigquery.metadataViewer"
  member  = google_service_account.federated-query.member
}


resource "google_bigquery_dataset_iam_member" "federated_query_dataset_access" {
  dataset_id = google_bigquery_dataset.tsm_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = google_service_account.federated-query.member
}

resource "google_bigquery_data_transfer_config" "query_config" {
  depends_on             = [google_bigquery_dataset_iam_member.federated_query_dataset_access, google_bigquery_dataset.tsm_dataset, google_bigquery_connection.regulus_maximus, google_bigquery_table.regulus_maximus, google_project_iam_member.tsm_terraform_service_account_user]
  display_name           = "regulus-maximus"
  location               = var.location
  data_source_id         = "scheduled_query"
  schedule               = "every day 03:00"
  destination_dataset_id = google_bigquery_dataset.tsm_dataset.dataset_id
  service_account_name   = google_service_account.federated-query.email
  params = {
    destination_table_name_template = google_bigquery_table.regulus_maximus.table_id
    write_disposition               = "WRITE_TRUNCATE"
    query                           = <<-SQL
    SELECT * FROM EXTERNAL_QUERY("${var.project}.${var.location}.${google_bigquery_connection.regulus_maximus.connection_id}", "SELECT * FROM sykmelding;");
    SQL
  }
}

data "google_service_account" "tsm_terraform" {
  account_id = "tsm-terraform"
}

resource "google_project_iam_member" "tsm_terraform_service_account_user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = data.google_service_account.tsm_terraform.member
}
