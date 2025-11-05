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

  