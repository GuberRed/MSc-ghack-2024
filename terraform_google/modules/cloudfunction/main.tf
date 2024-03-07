resource "google_cloudfunctions_function" "ghack-front-function" {
  name        = "${var.prefix}-function"
  description = "Obtain team sa and process team initiation via cloud build"
  runtime     = "python39"
  entry_point = "handle_request"
  project     = var.ops_project
  region      = var.ops_region

  source_archive_bucket = google_storage_bucket.cfbucket.name
  source_archive_object = "ghackcf.zip"

  available_memory_mb = 256
  timeout             = 60

  environment_variables = {
    PREFIX = "${var.prefix}"
    OPS_PROJECT = "${var.ops_project}"
  }

  trigger_http = true

}

resource "google_storage_bucket" "cfbucket" {
  name     = "${var.prefix}-bucket"
  location = "eu"
}

resource "google_storage_bucket_object" "archive" {
  name   = "ghackcf.zip"
  bucket = google_storage_bucket.cfbucket.name
  source = "../cf"
}

resource "google_pubsub_topic" "trigger_topic" {
  name = "${var.prefix}-topic"
}
