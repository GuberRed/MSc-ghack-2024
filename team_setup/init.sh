# Replace these variables with your actual values
SERVICE_ACCOUNT_EMAIL="test-01@gcp-coe-msp-sandbox.iam.gserviceaccount.com"
PROJECT_ID="abel-ghack-infra"

#publish pubsub
gcloud pubsub topics publish projects/abel-ghack-infra/topics/projects/abel-ghack-infra/topics/ghack-team-create-topic --message $SERVICE_ACCOUNT_EMAIL

# Create a new gcloud configuration
gcloud config configurations create ghackinfra

# Set project for the new configuration
gcloud config set project $PROJECT_ID --configuration ghackinfra

# Set the account and access token for the new configuration
gcloud config set account $SERVICE_ACCOUNT_EMAIL --configuration ghackinfra

# Switch to the new configuration
gcloud config configurations activate ghackinfra

#impersonate sa
gcloud config set auth/impersonate_service_account $SERVICE_ACCOUNT_EMAIL

gcloud auth login

#verify
gcloud config list

#get cluster credentials
gcloud container clusters get-credentials ghack-cluster --region europe-west1 --project $PROJECT_ID