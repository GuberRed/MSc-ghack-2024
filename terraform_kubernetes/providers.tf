terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
  }
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "gke_${var.ops_project}_${var.ops_region}-c_${var.prefix}-cluster"
}