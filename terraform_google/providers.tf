terraform {
  required_providers {
    google = ">= 5.12.0"
  }
  cloud {
    organization = "Devoteam-G-Cloud"

    workspaces {
      name = "ghack-infra-google"
    }
  }
}
# provider "google" {
#   alias = "impersonation"
#   scopes = [
#     "https://www.googleapis.com/auth/cloud-platform",
#     "https://www.googleapis.com/auth/userinfo.email",
#   ]
# }

# data "google_service_account_access_token" "default" {
#   provider = google.impersonation
#   target_service_account = var.terraform_service_account
#   scopes = [
#     "userinfo-email",
#     "cloud-platform"]
#   lifetime = "1200s"
# }

provider "google" {
  project = var.ops_project
  region = var.ops_region
  credentials = file("../abel-ghack-infra-key.json")

  # access_token = data.google_service_account_access_token.default.access_token
  # request_timeout = "60s"
  default_labels = {
    env-label = "${var.prefix}"
  }
}