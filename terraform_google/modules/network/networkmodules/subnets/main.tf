resource "google_compute_subnetwork" "subnetwork" {
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_ip
  region                   = var.subnet_region
  private_ip_google_access = var.subnet_private_access
  network                  = var.network_name
  project                  = var.project_id
  description              = var.description

  purpose = var.purpose
  role    = var.role
}