## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv .devops
	. .devops/bin/activate

install:
	# This should be run from inside a virtualenv
	pip3 install --upgrade pip &&\
		pip3 install -r requirements.txt
		
install-hadolint:
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 && ls
	sudo chmod +x /bin/hadolint
	sudo apt-get install pylint
	
install-circleci:
	sudo wget https://github.com/CircleCI-Public/circleci-cli/releases/download/v0.1.7411/circleci-cli_0.1.7411_linux_amd64.tar.
	tar zxvf circleci-cli_0.1.7411_linux_amd64.tar.gz
	cd circleci-cli_0.1.7411_linux_amd64
	
install-kuber: 
	curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
	sudo chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl
	kubectl version --client

install-minikube:
	sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
	&& sudo chmod +x minikube
	sudo mkdir -p /usr/local/bin/
	sudo install minikube /usr/local/bin/
	# sudo rm minikube
  
install-docker: 
	sudo apt-get update -y
	sudo apt-get install docker.io -y
	# sudo groupadd docker
	sudo usermod -aG docker ubuntu

install-git: 
	apt-get install git-core

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint app.py

all: install lint test
