#!/usr/bin/env bash

set -e

dir="$(dirname "$(realpath "$0")")"

img=corne-wireless-view-zmk-config
docker build . -t $img &&
mkdir -p artifacts &&
docker run --rm \
    -v "$dir/artifacts:/workspace/build/artifacts" \
    -v "$dir/config:/workspace/config" \
    -v "$dir/build.yaml:/workspace/build.yaml" \
    "$img"
