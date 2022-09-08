#!/bin/bash
docker build -t jamfire/eduwordpress:latest .

docker image push jamfire/eduwordpress:latest
