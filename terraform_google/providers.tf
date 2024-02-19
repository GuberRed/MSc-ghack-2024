terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Devoteam-G-Cloud"
    workspaces {
      name = "ghack-infra-google"
    }
  }
  required_providers {
    google = ">= 5.12.0"
  }
}

provider "google" {
  project     = var.ops_project
  region      = var.ops_region
  credentials = var.credentials
  default_labels = {
    env-label = "${var.prefix}"
  }
}
