#!/bin/bash
docker build -t jamfire/edumoodle3:latest .

docker image push jamfire/edumoodle3:latest
