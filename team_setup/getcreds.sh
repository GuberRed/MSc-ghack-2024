#get cluster credentials
gcloud container clusters get-credentials ghack-cluster --region europe-west1 --project $PROJECT_ID

# Get the secret payload
SECRET_PAYLOAD=$(gcloud secrets versions access latest --secret="$team_namespace" --project="$PROJECT_ID" --format='get(payload.data)' | base64 -d)

echo "Secret payload: $SECRET_PAYLOAD"