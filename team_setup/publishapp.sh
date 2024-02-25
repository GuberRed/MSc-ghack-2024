gcloud auth configure-docker europe-west1-docker.pkg.dev
docker build -t gubgub:0.2 .
docker tag gubgub:0.2 europe-west1-docker.pkg.dev/abel-ghack-infra/ghack-docker-repo/gubgub:latest
docker push europe-west1-docker.pkg.dev/abel-ghack-infra/ghack-docker-repo/gubgub:latest

docker buildx build --platform linux/amd64 -t gubgub:0.1 .
docker tag gubgub:0.1 europe-west1-docker.pkg.dev/abel-ghack-infra/ghack-docker-repo/gubgub:0.1
docker push europe-west1-docker.pkg.dev/abel-ghack-infra/ghack-docker-repo/gubgub:0.1

docker buildx build --push --platform linux/amd64 --tag europe-west1-docker.pkg.dev/abel-ghack-infra/ghack-docker-repo/gubgub:latest .