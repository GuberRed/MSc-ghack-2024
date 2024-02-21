# Replace these variables with your actual values
###########################
export SERVICE_ACCOUNT_EMAIL="tagger@gcp-coe-msp-sandbox.iam.gserviceaccount.com"
export PROJECT_ID="abel-ghack-infra"
############################

#namespace
export team_namespace="$(echo "$SERVICE_ACCOUNT_EMAIL" | awk -F'[@.]' '{print $1}')-$(echo "$SERVICE_ACCOUNT_EMAIL" | awk -F'[@.]' '{print $2}')"

#publish pubsub
gcloud pubsub topics publish projects/abel-ghack-infra/topics/ghack-team-create-topic --message $SERVICE_ACCOUNT_EMAIL

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

