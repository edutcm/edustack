#!/bin/bash


BLUE='\033[0;34m'
NC='\033[0m'

printf "${BLUE}[docker]${NC} Building edumoodle:latest... \r\n"

docker build \
    -t jamfire/edumoodle:latest \
    --build-arg VERSION=400 \
    .

printf "${BLUE}[docker]${NC} Push edumoodle to docker hub... \r\n"
docker image push jamfire/edumoodle:latest

