terraform {
  backend "gcs" {
    bucket  = "ag-ghack-tf-state"
    prefix  = "terraform/state"
  }
}
