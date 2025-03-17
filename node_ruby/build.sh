#!/bin/bash -ex

if [ -z "$NODE_VERSION" ]; then
    read -p "Node version: " NODE_VERSION
fi
if [ -z "$RUBY_VERSION" ]; then
    read -p "Ruby version: " RUBY_VERSION
fi
TAG=$RUBY_VERSION-$NODE_VERSION

docker buildx use multiplatform-builder || docker buildx create --name multiplatform-builder --driver docker-container --bootstrap --use

docker buildx build -t insurgate/node_ruby:$TAG-slim --build-arg NODE_VERSION=$NODE_VERSION --build-arg RUBY_VERSION=$RUBY_VERSION --build-arg SUFFIX='-slim' --push .
docker buildx build -t insurgate/node_ruby:$TAG --build-arg NODE_VERSION=$NODE_VERSION --build-arg RUBY_VERSION=$RUBY_VERSION --push .
docker buildx build -t insurgate/node_ruby:$TAG-builder --build-arg NODE_VERSION=$NODE_VERSION --build-arg RUBY_VERSION=$RUBY_VERSION --build-arg BUILDER=true --platform linux/amd64,linux/arm64 --push .
