#1. How to obtain cluster name from diffrent terraform deployment output into var. if i will use data block it wont be smooth.

###kubernetes/main.tf:5
```resource "null_resource" "get-credentials" {
 provisioner "local-exec" {
   command = "gcloud container clusters get-credentials ${var.ghack_cluster_name} --zone=europe-west1-c"
 }
}
```
#
#2. SA and bucket must be created before running terraform

###both/backend.tf
NEW
```terraform {
  backend "gcs" {
   bucket  = "ag-ghack-gcp-coe-msp-sandbox-tfstate"
    prefix  = "terraform/kubernetes/state"
    impersonate_service_account = "ag-ghack-terraform@gcp-coe-msp-sandbox.iam.gserviceaccount.com"
  }
}
```
OLD
```terraform {
  backend "gcs" {
  }
}```
i could create bucket in pipeline then provide his name when 
```gsutil mb -p $OPS_PROJECT  -l $OPS_REGION -b on $BUCKET
terraform init \
    -backend-config="bucket=${BUCKET_NAME}" \
    -backend-config="prefix=terraform-state" \
    -backend-config="impersonate_service_account=${TF_SA}@${OPS_PROJECT}.iam.gserviceaccount.com"
```

#3. Its not smooth as it was in one deployment look v1name and v2name

###kubernetes/main.tf:5
```subject {
    #api_group = "rbac.authorization.k8s.io"
    kind = "User"
    v1name = google_service_account.gke_teamsa[count.index].email
    v2name = "${var.teams[count.index]}-sa@prj-${var.teams[count.index]}.iam.gserviceaccount.com"
  }
```
#4. Also i got some random timeout at first run (kubernetes) after (google) on second everything works fine dunno why

#5.cloud run pipeline idea below
    step1:google terraform apply - projects/cluster/iam/artifactregistry
    step2:kubernetes terraform apply
    step3:build docker images for front/sql and publish them to artifact registry
    step4:deploy app inside each namespace
    ...