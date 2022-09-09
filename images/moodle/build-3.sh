#!/bin/bash


BLUE='\033[0;34m'
NC='\033[0m'

printf "${BLUE}[docker]${NC} Building edumoodle:311... \r\n"

docker build \
    -t jamfire/edumoodle3:latest \
    --build-arg VERSION=311 \
    .

# printf "${BLUE}[docker]${NC} Building edumoodle:400... \r\n"

# docker build \
#     -t jamfire/edumoodle:400 \
#     --build-arg VERSION=400 \
#     .

printf "${BLUE}[docker]${NC} Push edumoodle to docker hub... \r\n"
docker image push jamfire/edumoodle3:latest
# docker image push jamfire/edumoodle:400

