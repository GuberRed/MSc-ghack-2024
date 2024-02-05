resource "google_project_service" "project" {
  project = var.ops_project
  service = "iam.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}
resource "google_project" "my_project" {
  name       = "${var.prefix}-main"
  project_id = "${var.prefix}-main"
  org_id     = "1234567"
}