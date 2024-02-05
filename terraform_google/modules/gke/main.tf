
resource "google_service_account" "ghack_cluster_sa" {
  account_id   = "${var.prefix}-cluster-sa"
  display_name = "${var.prefix}-cluster-sa"
}

resource "google_container_cluster" "ghack_cluster" {
  name     = "${var.prefix}-cluster"
  location = "${var.ops_region}-c"
  remove_default_node_pool = true
  initial_node_count = 1
  deletion_protection = false
}

resource "google_container_node_pool" "ghack_cluster_node_pool" {
  name       = "${var.prefix}-np"
  cluster    = google_container_cluster.ghack_cluster.id
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.ghack_cluster_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}