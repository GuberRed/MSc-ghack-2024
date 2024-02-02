provider "google" {
  alias = "impersonation"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider = google.impersonation
  target_service_account = var.terraform_service_account
  scopes = [
    "userinfo-email",
    "cloud-platform"]
  lifetime = "1200s"
}

provider "google" {
  project = var.ops_project
  region = var.ops_region

  access_token = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
  default_labels = {
    env-label = "${var.prefix}"
  }
}
resource "google_container_cluster" "ghack_cluster" {
  name     = "${var.prefix}-cluster"
  location = var.ops_region
}

variable "teams" {
  default = ["team1", "team2", "team3"]
}

resource "kubernetes_namespace" "team_namespaces" {
  count = length(var.teams)
  metadata {
    name = var.teams[count.index]
  }
  depends_on = [google_container_cluster.ghack_cluster]
}
