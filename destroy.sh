cd terraform
terraform destroy --auto-approve
cd ..
gcloud storage rm --recursive $BUCKET 
gsutil rm -r $BUCKET
echo "delete old terraform files:"
rm -rf terraform/.terraform
rm terraform/.terraform.lock.hcl
echo "delete artifacts repository:"
gcloud artifacts repositories delete $DOCKER_REPO_NAME --location=$COMPUTE_REGION
gcloud iam service-accounts delete "${TF_SA}@${PROJECT_ID}.iam.gserviceaccount.com"
echo "delete gcloud config"
gcloud config configurations activate default
gcloud config configurations delete $CONFIG