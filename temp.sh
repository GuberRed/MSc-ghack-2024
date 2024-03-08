gcloud functions add-iam-policy-binding function-1 \
  --region europe-west1 \
  --member=allUsers \
  --role=roles/cloudfunctions.invoker \
  --project=abel-ghack-infra

gcloud functions remove-iam-policy-binding function-1 \
  --region europe-west1 \
  --member=allUsers \
  --role=roles/cloudfunctions.invoker \
  --project=abel-ghack-infra