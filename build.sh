#!/usr/bin/env bash

img=corne-wireless-view-zmk-config
docker build . -t $img &&
mkdir -p artifacts &&
docker run $img ls /workspace/build/artifacts/ | while read f; do 
  docker run --rm --entrypoint cat $img "/workspace/build/artifacts/$f" > "artifacts/$f"
  echo "Created \"artifacts/$f\""
done
