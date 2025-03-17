#!/bin/bash -ex

if [ -z "$1" ]; then
    echo "Usage: $0 <kamal-version>"
    exit 1
else
    KAMAL_VERSION=$1
fi

docker buildx use multiplatform-builder || docker buildx create --name multiplatform-builder --driver docker-container --bootstrap --use

docker buildx build \
    -t insurgate/kamal:$KAMAL_VERSION \
    -t insurgate/kamal:latest \
    --build-arg KAMAL_VERSION=$KAMAL_VERSION \
    --platform linux/amd64 \
    --push \
    .
