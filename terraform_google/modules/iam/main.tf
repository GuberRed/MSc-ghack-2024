resource "google_project_iam_custom_role" "gke-team-role" {
  project     = var.ops_project
  role_id     = "${var.prefix}teamrole"
  title       = "GKE ghack team role"
  permissions = ["container.clusters.get"]
}