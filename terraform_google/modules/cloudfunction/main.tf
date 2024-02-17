resource "google_cloudfunctions_function" "create-namespace" {
  name        = "${prefix}-function"
  description = "Create namespace in GKE cluster"
  runtime     = "python39"
  entry_point = "create_namespace"
  project     = var.ops_project
  region      = var.ops_region

  source_archive_bucket = google_storage_bucket.cfbucket.name
  source_archive_object = "cloudfunction.zip"

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

resource "google_storage_bucket" "cfbucket" {
  name     = "${var.prefix}-bucket"
  location = "eu"
}

resource "google_storage_bucket_object" "archive" {
  name   = "cloudfunction.zip"
  bucket = google_storage_bucket.cfbucket.name
  source = "../terraform_kubernetes/cf"
}

resource "google_pubsub_topic" "trigger_topic" {
  name = "${var.prefix}-topic"
}
