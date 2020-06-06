pipeline {
     agent any
     stages {
         stage('Install Dependencies') {
             steps {
                 sh 'make setup'
                 sh 'make install'
                 sh 'make install-hadolint'
                 sh 'make install-docker'
             }
         }
         stage('Lint Dockerfile and Python') {
             steps {
                 sh 'make lint'
             }
         }
         stage('Build') {
             steps {
                 sh 'sudo docker build --tag mtwatson/udacity-docker-milestone .'
             }
         }
         stage('Publish') {
             steps {
                withDockerRegistry([ credentialsId: 'dockerhub', url: '' ]) {
                    sh './upload_docker.sh'
                }
             }
         }
     }
}