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
# Authenticate & tag
# echo "Docker ID and Image: $dockerpath"
cat /home/ec2-user/environment/password.txt | docker login --username mtwatson --password-stdin



# Step 3:
# Push image to a docker repository
docker commit $dockerId mtwatson/udacity-docker-milestone
docker push $dockerpath


