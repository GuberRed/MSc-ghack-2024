resource "google_cloudfunctions_function" "ghack-front-function" {
  name        = "${var.prefix}-function"
  description = "Obtain team sa and process team initiation via cloud build"
  runtime     = "python39"
  entry_point = "team_init"
  project     = var.ops_project
  region      = var.ops_region

  source_archive_bucket = google_storage_bucket.cfbucket.name
  source_archive_object = "ghackcfinit.zip"

  available_memory_mb = 256
  timeout             = 60

  trigger_http = true

}

resource "google_storage_bucket" "cfbucket" {
  name     = "${var.prefix}-bucket"
  location = "eu"
  force_destroy = true
}

resource "google_storage_bucket_object" "archive" {
  name   = "ghackcfinit.zip"
  bucket = google_storage_bucket.cfbucket.name
  source = "modules/cloudfunction/ghackcfinit.zip"
}

resource "google_cloudfunctions_function_iam_binding" "iam_public_access_for_cf" {
  project = var.ops_project
  region  = var.ops_region
  cloud_function = google_cloudfunctions_function.ghack-front-function.name

  role    = "roles/cloudfunctions.invoker"

  members = [
    "allUsers"
  ]
}
