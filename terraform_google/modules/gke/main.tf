resource "google_container_cluster" "ghack_cluster" {
  name       = "${var.prefix}-cluster"
  project    = var.ops_project
  location   = var.ops_region
  network    = var.ops_network
  subnetwork = var.ops_subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
}

resource "google_container_node_pool" "ghack_cluster_node_pool" {
  name       = "${var.prefix}-np"
  cluster    = google_container_cluster.ghack_cluster.id
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}