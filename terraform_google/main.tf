resource "google_project_service" "api_gke_enable" {
  project = var.ops_project
    service = "container.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

module "gke_ghack_cluster" {
  source = "./modules/gke"
  ops_project = var.ops_project
  ops_region =  var.ops_region
  ops_network = "${var.prefix}-vpc"
  ops_subnetwork = "${var.prefix}-subnet"

  prefix = var.prefix
  depends_on = [ 
    google_project_service.api_gke_enable,
    module.network 
    ]
}

module "projects_teams" {
  source = "./modules/team-sa"
  teams = var.teams
  prefix = var.prefix
  ops_project = var.ops_project
}
module "network" {
  source = "./modules/network"
  ops_project = var.ops_project
  prefix = var.prefix
  compute_region = var.ops_region
}