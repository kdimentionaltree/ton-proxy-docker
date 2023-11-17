#!/bin/bash
set -e

docker compose -f docker-compose.swarm.yaml build
docker compose -f docker-compose.swarm.yaml push
docker stack deploy -c docker-compose.swarm.yaml ton-page
