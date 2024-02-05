export PREFIX=ag-ghack
export OPS_PROJECT=gcp-coe-msp-sandbox
export TF_SA=${PREFIX}-terraform
export OPS_REGION=europe-west1
export BUCKET_NAME=${PREFIX}-${OPS_PROJECT}-tfstate
export BUCKET=gs://${BUCKET_NAME}
export DOCKER_REPO_NAME=${PREFIX}-docker-repo
export CONFIG=${PREFIX}-gcl-config
export ACCOUNT=adam.gubernat@devoteam.com
export TF_FULL_SA=${TF_SA}@${OPS_PROJECT}.iam.gserviceaccount.com

echo "Do you want to run infra? to continue, type yes"

read userInput
if [ "$userInput" == "yes" ]; then
    echo "running script"
else
    echo "exit"
    exit 1
fi

gcloud config configurations create $CONFIG
gcloud config set project $OPS_PROJECT
gcloud config set account $ACCOUNT
gcloud config set compute/region $OPS_REGION

gcloud config configurations activate $CONFIG
#gcloud auth login
#gcloud auth application-default login

sed -i '' '/prefix =/d' terraform/terraform.tfvars
sed -i '' '/ops_project =/d' terraform/terraform.tfvars
sed -i '' '/ops_region =/d' terraform/terraform.tfvars
sed -i '' '/terraform_service_account =/d' terraform/terraform.tfvars

echo "prefix = \"${PREFIX}\"" >> terraform/terraform.tfvars
echo "ops_project = \"${OPS_PROJECT}\"" >> terraform/terraform.tfvars
echo "ops_region = \"${OPS_REGION}\"" >> terraform/terraform.tfvars
echo "terraform_service_account = \"${TF_SA}@${OPS_PROJECT}.iam.gserviceaccount.com\"" >> terraform/terraform.tfvars

./scripts/prepare_enable_gcp_apis.sh
gsutil mb -p $OPS_PROJECT  -l $OPS_REGION -b on $BUCKET
./scripts/prepare_terraform_service_account.sh
gcloud artifacts repositories create $DOCKER_REPO_NAME --repository-format=docker --location=$OPS_REGION --description="Docker repository for ghack infra challange"

./scripts/deploy_terraform.sh
