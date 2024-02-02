#!/bin/bash

#
# /*
#  * Copyright 2023 Google LLC
#  *
#  * Licensed under the Apache License, Version 2.0 (the "License");
#  * you may not use this file except in compliance with the License.
#  * You may obtain a copy of the License at
#  *
#  *     https://www.apache.org/licenses/LICENSE-2.0
#  *
#  * Unless required by applicable law or agreed to in writing, software
#  * distributed under the License is distributed on an "AS IS" BASIS,
#  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  * See the License for the specific language governing permissions and
#  * limitations under the License.
#  */
#
set -e

gcloud iam service-accounts create "${TF_SA}" \
    --description="Used by Terraform to deploy GCP resources" \
    --display-name="Terraform Service Account"

# gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
#     --member="serviceAccount:${TF_SA}@${PROJECT_ID}.iam.gserviceaccount.com" \
#     --role="roles/owner" \
#     --condition=None

ROLES=(
  "roles/datacatalog.tagTemplateCreator"
  "roles/pubsub.editor"
  "roles/compute.securityAdmin"
  "roles/iam.serviceAccountUser"
  "roles/pubsub.admin"
  "roles/compute.networkAdmin"
  "roles/datastore.owner"
  "roles/cloudscheduler.admin"
  "roles/vpcaccess.admin"
  "roles/bigquery.dataEditor"
  "roles/storage.admin"
  "roles/compute.networkAdmin"
  "roles/logging.admin"
  "roles/resourcemanager.projectIamAdmin"
  "roles/backupdr.cloudStorageOperator"
  "roles/iam.serviceAccountAdmin"
  "roles/serviceusage.serviceUsageConsumer"
  "roles/dns.admin"
  "roles/iam.serviceAccountTokenCreator"
  "roles/run.admin"
)

# Loop through roles and add them
for role in "${ROLES[@]}"; do
  gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member="serviceAccount:${TF_SA}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role="${role}" \
    --condition=None
    sleep 1
done