
#project creation for team
resource "google_service_account" "gke_teamsa" {
  count        = length(var.teams)
  project = var.project
  account_id   = "teamsa-${var.teams[count.index]}"
  display_name = "teamsa-${var.teams[count.index]}"
}
