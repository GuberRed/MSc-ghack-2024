resource "google_service_account" "ghack_cluster_sa" {
  account_id   = "ghack-cluster-sa"
  display_name = "ghack-cluster-sa"
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
  node_count = 3

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
# Get the credentials 
resource "null_resource" "get-credentials" {

 depends_on = [google_container_node_pool.ghack_cluster_node_pool] 
 provisioner "local-exec" {
   command = "gcloud container clusters get-credentials ${google_container_cluster.ghack_cluster.name} --zone=europe-west1-c"
 }
}

#https://registry.terraform.io/modules/blackbird-cloud/gke-namespace/google/latest
resource "kubernetes_namespace" "team_namespaces" {
  count = length(var.teams)
  metadata {
    name = var.teams[count.index]
  }
  depends_on = [null_resource.get-credentials]
}


#https://github.com/gruntwork-io/terraform-kubernetes-namespace/blob/v0.5.1/modules/namespace-roles/main.tf
# resource "kubernetes_role" "rbac_role_access_read_only" {
#   count      = var.create_resources ? 1 : 0
#   depends_on = [null_resource.dependency_getter]

#   metadata {
#     name        = "${var.namespace}-access-read-only"
#     namespace   = var.namespace
#     labels      = var.labels
#     annotations = var.annotations
#   }

#   rule {
#     api_groups = ["*"]
#     resources  = ["*"]
#     verbs      = ["get", "list", "watch"]
#   }
# }
