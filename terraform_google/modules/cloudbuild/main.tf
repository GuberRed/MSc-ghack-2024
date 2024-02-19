resource "google_cloudbuild_trigger" "ghack_cloudbuild_trigger" {
  location    = var.ops_region
  name        = "${var.prefix}-teamsa-setup-trigger"
  description = "create namespace and rbac role in ghack cluster for sa provided via pubsub"
  project = var.ops_project

  substitutions = {
    "_CLUSTER_NAME" = "xxxx"
  }
  filename = "terraform_kubernetes/cloudbuild/cloudbuild.yaml"

  source_to_build {
    uri       = "https://github.com/devoteamgcloud/ghack-infra-2024"
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }

  pubsub_config {
    topic = google_pubsub_topic.trigger_topic.id
  }
  
  service_account = "projects/-/serviceAccounts/tfc-ghack-sa@abel-ghack-infra.iam.gserviceaccount.com"
  depends_on = [ google_pubsub_topic.trigger_topic ]
}

resource "google_pubsub_topic" "trigger_topic" {
  name = "${var.prefix}-team-create-topic"
}
resource "google_pubsub_subscription" "team-subscription" {
  name  = "${var.prefix}-team-create-sub"
  topic = google_pubsub_topic.trigger_topic.id

  ack_deadline_seconds = 20

  depends_on = [ google_pubsub_topic.trigger_topic ]
}