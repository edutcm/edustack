#!/bin/bash
docker build -t jamfire/edumoodle:latest .

docker image push jamfire/edumoodle:latest
