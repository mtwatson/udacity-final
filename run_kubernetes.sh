#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath="mtwatson/udacity-docker-milestone"

# Step 2
# Run the Docker Hub container with kubernetes
# docker swarm init
# docker stack deploy --compose-file ./docker-compose.yml udacityStack
# docker stack services udacityStack

kubectl run udacity-stack --image=mtwatson/udacity-docker-milestone --port=80

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward udacity-stack 8000:80

