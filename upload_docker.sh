#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath="mtwatson/udacity-docker-milestone"
dockerId=$(docker images --format="{{.Repository}} {{.ID}}" | grep "^mtwatson/udacity-docker-milestone " | cut -d' ' -f2)
tagName="first-attempt"

# Step 2:
# Push image to a docker repository
sudo docker commit $dockerId mtwatson/udacity-docker-milestone
sudo docker push $dockerpath


