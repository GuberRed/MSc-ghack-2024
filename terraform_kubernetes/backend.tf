terraform {
  backend "gcs" {
    bucket                      = "ag-ghack-gcp-coe-msp-sandbox-tfstate"
    prefix                      = "terraform/kubernetes/state"
    impersonate_service_account = "ag-ghack-terraform@gcp-coe-msp-sandbox.iam.gserviceaccount.com"
  }
}
