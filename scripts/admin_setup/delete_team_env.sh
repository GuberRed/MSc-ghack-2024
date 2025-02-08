###########################
export SERVICE_ACCOUNT_EMAIL="dispatcher@gcp-coe-msp-sandbox.iam.gserviceaccount.com"
############################

#namespace
export team_namespace="$(echo "$SERVICE_ACCOUNT_EMAIL" | awk -F'[@.]' '{print $1}')-$(echo "$SERVICE_ACCOUNT_EMAIL" | awk -F'[@.]' '{print $2}')"
export teamname=$(echo "$SERVICE_ACCOUNT_EMAIL" | awk -F'[@.]' '{print $1}')
# Delete all resources within the namespace
kubectl delete all --all -n "$team_namespace"

# Delete the namespace itself
kubectl delete namespace "$team_namespace"

gcloud secrets delete "$team_namespace" --quiet --project="abel-ghack-infra"

gcloud artifacts docker images delete "europe-west1-docker.pkg.dev/abel-ghack-infra/ghack-docker-repo/gubgubdb:${team_namespace}"
