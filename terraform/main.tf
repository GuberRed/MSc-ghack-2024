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
# Get the credentials 
resource "null_resource" "get-credentials" {

 depends_on = [google_container_node_pool.ghack_cluster_node_pool] 
 provisioner "local-exec" {
   command = "gcloud container clusters get-credentials ${google_container_cluster.ghack_cluster.name} --zone=europe-west1-c"
 }
}

resource "kubernetes_namespace" "gke_team_namespaces" {
  count = length(var.teams)
  metadata {
    name = var.teams[count.index]
  }
  depends_on = [null_resource.get-credentials]
}

resource "kubernetes_role" "gke_rbac_role_definition" {
 count = length(var.teams)
  depends_on = [kubernetes_namespace.gke_team_namespaces]

  metadata {
    name        = "${var.teams[count.index]}-role"
    namespace   = var.teams[count.index]
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "google_service_account" "gke_teamsa" {
  count        = length(var.teams)
  account_id   = "teamsa-${var.teams[count.index]}"
  display_name = "teamsa-${var.teams[count.index]}"
}

#https://gcloud.devoteam.com/blog/the-ultimate-security-guide-to-rbac-on-google-kubernetes-engine/
#https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control#rolebinding#
resource "kubernetes_role_binding" "gke_rbac_role_binding" {
  count = length(var.teams)

  metadata {
    name      = "${var.teams[count.index]}-binding"
    namespace = var.teams[count.index]
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.gke_rbac_role_definition[count.index].metadata[0].name
  }

  subject {
    #api_group = "rbac.authorization.k8s.io"
    kind = "User"
    name      = google_service_account.gke_teamsa[count.index].email
  }

  depends_on = [kubernetes_role.gke_rbac_role_definition]
}
#kubectl get rolebinding,clusterrolebinding --all-namespaces
#kubectl get roles
#kubectl describe role teama-role -n teama