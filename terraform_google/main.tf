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
  prefix = var.prefix
  depends_on = [ google_project_service.api_gke_enable ]
}

module "projects_teams" {
  source = "./modules/projects_teams"
  teams = var.teams
  project = var.ops_project
}
