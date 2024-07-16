#!/bin/bas
# 設定
PROJECT_ID="your-project"
REGION="us-central1"
REPOSITORY_NAME="my-repo-for-tf-server"
IMAGE_NAME="hello-world"
TAG="latest"

# Docker コンテナを Google Artifact Registry 用にタグ付け
docker build -t $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/$IMAGE_NAME:$TAG .
docker tag hello-world $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/$IMAGE_NAME:$TAG

# Docker コンテナを Google Artifact Registry にプッシュ
docker push $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/$IMAGE_NAME:$TAG

echo "Docker image $IMAGE_NAME:$TAG successfully pushed to Google Artifact Registry"
