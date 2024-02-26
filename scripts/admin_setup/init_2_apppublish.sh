gcloud auth configure-docker europe-west1-docker.pkg.dev
docker buildx build --push --platform linux/amd64 --tag europe-west1-docker.pkg.dev/abel-ghack-infra/ghack-docker-repo/gubgub:latest .
