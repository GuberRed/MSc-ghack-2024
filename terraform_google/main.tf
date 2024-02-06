module "gke_ghack_cluster" {
  source = "./modules/gke"
  ops_project = var.ops_project
  ops_region =  var.ops_region
  prefix = var.prefix
}

module "projects_teams" {
  source = "./modules/projects_teams"
  teams = var.teams
  project = var.ops_project
}
