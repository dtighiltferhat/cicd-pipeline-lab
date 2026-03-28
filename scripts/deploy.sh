#!/bin/bash
# scripts/deploy.sh
# Deploys the application container with the given image tag

set -e

IMAGE_TAG=${1:-latest}
APP_NAME="sample-app"
DOCKER_REGISTRY="dtighiltferhat"
CONTAINER_NAME="${APP_NAME}"
PORT=5000

echo "Deploying ${APP_NAME}:${IMAGE_TAG}..."

# Pull the specific image version
docker pull "${DOCKER_REGISTRY}/${APP_NAME}:${IMAGE_TAG}"

# Stop and remove existing container if running
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Stopping existing container..."
    docker stop "${CONTAINER_NAME}" || true
    docker rm "${CONTAINER_NAME}" || true
fi

# Run new container
docker run -d \
    --name "${CONTAINER_NAME}" \
    --restart unless-stopped \
    -p "${PORT}:${PORT}" \
    -e APP_ENV="${APP_ENV:-prod}" \
    -e BUILD_TAG="${IMAGE_TAG}" \
    "${DOCKER_REGISTRY}/${APP_NAME}:${IMAGE_TAG}"

echo "Deployment complete — ${APP_NAME}:${IMAGE_TAG} running on port ${PORT}"
