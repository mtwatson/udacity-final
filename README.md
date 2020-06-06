## CircleCi Status:
[![CircleCI](https://circleci.com/gh/mtwatson/docker-kube.svg?style=svg)](https://circleci.com/gh/circleci/circleci-docs)


## Overview

Basic python AI prediction program in a container + support for Kubernetes. It has various installation and lint steps located inside of the make file. It also has circleci integration

---

## Setup the Environment

* Create a virtualenv and activate it
* Run `make install` to install the basic necessary dependencies.
  This includes:
    1. pip + upgrade pip
    2. All Python software located inside of requirements.txt
* Run `make install hadolint` to install Hadolint.
* Run `make install-circleci` to install CircleCi.
* Run `make install-kuber` to install kubernetes.
* Run `make install-minikube` to install minikube.
* Run `make lint` to lint the project code, which includes both pylint and Hadolint.

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

