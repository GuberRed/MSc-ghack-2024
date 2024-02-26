# Replace these variables with your actual values
###########################
export SERVICE_ACCOUNT_EMAIL="snapshoter-bq@gcp-coe-msp-sandbox.iam.gserviceaccount.com"
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

#gcloud auth activate-service-account $SERVICE_ACCOUNT_EMAIL
gcloud auth login

sleep 18

#get cluster credentials
gcloud container clusters get-credentials ghack-cluster --region europe-west1 --project $PROJECT_ID

sleep 35
# Get the secret payload
SECRET_PAYLOAD=$(gcloud secrets versions access latest --secret="$team_namespace" --project="$PROJECT_ID" --format='get(payload.data)' | base64 -d)

echo "Secret payload: $SECRET_PAYLOAD"
#verify
gcloud config list

