resource "google_project_service" "api_enable" {
  for_each = toset([
    "container.googleapis.com", "secretmanager.googleapis.com"
  ])

  project = var.ops_project
  service = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

module "gke_ghack_cluster" {
  source         = "./modules/gke"
  ops_project    = var.ops_project
  ops_region     = var.ops_region
  ops_network    = module.network.network_self_link
  ops_subnetwork = module.network.subnet_self_link

  prefix = var.prefix
  depends_on = [
    google_project_service.api_enable,
    module.network
  ]
}

# module "projects_teams" {
#   source      = "./modules/team-sa"
#   teams       = var.teams
#   prefix      = var.prefix
#   ops_project = var.ops_project
# }
module "network" {
  source         = "./modules/network"
  ops_project    = var.ops_project
  prefix         = var.prefix
  compute_region = var.ops_region
}
module "iam" {
  source      = "./modules/iam"
  ops_project = var.ops_project
  prefix      = var.prefix
}
module "cloud_build" {
  source       = "./modules/cloudbuild"
  ops_project  = var.ops_project
  prefix       = var.prefix
  ops_region   = var.ops_region
  cluster_name = module.gke_ghack_cluster.output_cluster_name

  depends_on = [module.gke_ghack_cluster, module.iam]
}
resource "google_artifact_registry_repository" "ghack-docker-repo" {
  location      = var.ops_region
  repository_id = "${var.prefix}-docker-repo"
  description   = "Repo for Ghack app"
  format        = "DOCKER"
}

module "cloud_function" {
  source       = "./modules/cloudfunction"
  ops_project  = var.ops_project
  prefix       = var.prefix
  ops_region   = var.ops_region

  depends_on = [module.cloud_build]
}