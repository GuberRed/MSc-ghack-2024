resource "google_cloudfunctions_function" "create-namespace" {
  name        = "${prefix}-function"
  description = "Create namespace in GKE cluster"
  runtime     = "python39"
  entry_point = "create_namespace"
  project     = var.ops_project
  region      = var.ops_region

  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = "function_code.zip"

  available_memory_mb = 256
  timeout             = 60

  environment_variables = {
    GKE_CLUSTER = "${var.prefix}-cluster"
  }

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.trigger_topic.name
  }
}

resource "google_storage_bucket" "bucket" {
  name     = "test-bucket"
  location = "US"
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./path/to/zip/file/which/contains/code"
}

resource "google_pubsub_topic" "trigger_topic" {
  name = "${var.prefix}-topic"
}
