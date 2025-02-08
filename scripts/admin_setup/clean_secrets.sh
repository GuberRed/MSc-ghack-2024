SECRET_NAMES=$(gcloud secrets list --format="value(name)" --project="abel-ghack-infra")

for SECRET_NAME in $SECRET_NAMES; do
  echo "Deleting secret: $SECRET_NAME"
  gcloud secrets delete "$SECRET_NAME" --quiet --project="abel-ghack-infra"
done