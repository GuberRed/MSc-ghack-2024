#!/bin/bash
# exit script when errors occur
set -e

# set the working dir as the scripts directory
cd "$(dirname "$0")"

cd ../terraform

terraform init \
    -backend-config="bucket=${BUCKET_NAME}" \
    -backend-config="prefix=terraform-state" \
    -backend-config="impersonate_service_account=${TF_SA}@${OPS_PROJECT}.iam.gserviceaccount.com"
terraform workspace select default

terraform apply -auto-approve
cd ..