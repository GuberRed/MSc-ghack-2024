resource "google_service_account" "gke_teamsa" {
  count        = length(var.teams)
  project      = var.ops_project
  account_id   = "${var.prefix}-teamsa-${var.teams[count.index]}"
  display_name = "${var.prefix}-teamsa-${var.teams[count.index]}"
}