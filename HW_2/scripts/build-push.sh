#!/bin/sh
set -eu
cd "$(dirname "$0")/.."

if [ -z "${IMAGE:-}" ] || [ -z "${TAG:-}" ]; then
    echo 'Укажите IMAGE и TAG'
    exit 1
fi

docker build --pull -t "$IMAGE:$TAG" .
docker push "$IMAGE:$TAG"
