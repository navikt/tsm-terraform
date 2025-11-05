resource "random_password" "bigquery_db_password" {
    length = 16
    special = false
}

resource "google_sql_user" "bigquery_db_user" {
    name = "bigquery-db-user"
    instance = "regulus-maximus-instance"
    password = random_password.bigquery_db_password.result

}

  