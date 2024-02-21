gcloud auth configure-docker europe-west1-docker.pkg.dev
docker build -t gubgub:0.1 .
docker push europe-west1-docker.pkg.dev/abel-ghack-infra/ghack-docker-repo/gubgub:0.1