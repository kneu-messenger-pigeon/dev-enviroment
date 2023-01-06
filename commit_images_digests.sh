#!/usr/bin/env sh
set -e

#  docker compose -f docker-compose.yml -f digests.yml config
echo "version: \"3.9\""
echo "services:"

for SERVICE in $(docker compose ps --services)
do
  ID=$(docker compose images  -q "${SERVICE}")

  if [ "$(docker inspect --format="{{index .RepoDigests}}" "$ID")" = "[]" ];
  then
    continue
  fi

  echo " \"${SERVICE}\":"
  echo "    image:" $(docker inspect --format="{{index .RepoDigests 0}}" "$ID")
done
