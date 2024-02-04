#!/bin/bash

set -e

gcloud iam service-accounts create "${TF_SA}" \
    --description="Used by Terraform to deploy GCP resources" \
    --display-name="Terraform Service Account"

gcloud projects add-iam-policy-binding "${OPS_PROJECT}" \
    --member="serviceAccount:${TF_SA}@${OPS_PROJECT}.iam.gserviceaccount.com" \
    --role="roles/owner" \
    --condition=None

# ROLES=(
#   "roles/datacatalog.tagTemplateCreator"
#   "roles/pubsub.editor"
#   "roles/compute.securityAdmin"
#   "roles/iam.serviceAccountUser"
#   "roles/pubsub.admin"
#   "roles/compute.networkAdmin"
#   "roles/datastore.owner"
#   "roles/cloudscheduler.admin"
#   "roles/vpcaccess.admin"
#   "roles/bigquery.dataEditor"
#   "roles/storage.admin"
#   "roles/compute.networkAdmin"
#   "roles/logging.admin"
#   "roles/resourcemanager.projectIamAdmin"
#   "roles/backupdr.cloudStorageOperator"
#   "roles/iam.serviceAccountAdmin"
#   "roles/serviceusage.serviceUsageConsumer"
#   "roles/dns.admin"
#   "roles/iam.serviceAccountTokenCreator"
#   "roles/run.admin"
# )

# Loop through roles and add them
# for role in "${ROLES[@]}"; do
#   gcloud projects add-iam-policy-binding "${OPS_PROJECT}" \
#     --member="serviceAccount:${TF_SA}@${OPS_PROJECT}.iam.gserviceaccount.com" \
#     --role="${role}" \
#     --condition=None
#     sleep 1
# done