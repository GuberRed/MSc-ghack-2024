
# Get the credentials 
resource "null_resource" "get-credentials" {
 provisioner "local-exec" {
   command = "gcloud container clusters get-credentials ${var.ghack_cluster_name} --zone=europe-west1-c"
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
    #name = google_service_account.gke_teamsa[count.index].email
    name = "${var.teams[count.index]}-sa@prj-${var.teams[count.index]}.iam.gserviceaccount.com"
  }

  depends_on = [kubernetes_role.gke_rbac_role_definition]
}
#kubectl get rolebinding,clusterrolebinding --all-namespaces
#kubectl get roles
#kubectl describe role teama-role -n teama