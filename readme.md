#1. How to obtain cluster name from diffrent terraform deployment

###kubernetes/main.tf:5
```resource "null_resource" "get-credentials" {
 provisioner "local-exec" {
   command = "gcloud container clusters get-credentials ${var.ghack_cluster_name} --zone=europe-west1-c"
 }
}
```

#2. SA and bucket must be created before running terraform

###both/backend.tf
```terraform {
  backend "gcs" {
   bucket  = "ag-ghack-gcp-coe-msp-sandbox-tfstate"
    prefix  = "terraform/kubernetes/state"
    impersonate_service_account = "ag-ghack-terraform@gcp-coe-msp-sandbox.iam.gserviceaccount.com"
  }
}
```

#3. Its not smooth as it was in one deployment

###kubernetes/main.tf:5
```subject {
    #api_group = "rbac.authorization.k8s.io"
    kind = "User"
    v1name = google_service_account.gke_teamsa[count.index].email
    v2name = "${var.teams[count.index]}-sa@prj-${var.teams[count.index]}.iam.gserviceaccount.com"
  }
```
#4. Also i got some random timeout at first run (kubernetes) after (google)