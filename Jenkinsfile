pipeline {
     agent any
     stages {
         stage('AWS Credentials') {
             steps {
                 withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'MyCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
                 {
                     sh """
                        sudo mkdir -p ~./aws
                        sudo echo "[default]" >~/.aws/credentials
                        sudo echo "[default]" >~/.boto
                        sudo echo "aws_access_key_id = ${AWS_ACCESS_KEY_ID}" >>~/.boto
                        sudo echo "aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" >>~/.boto
                        sudo echo "aws_access_key_id = ${AWS_ACCESS_KEY_ID}" >>~/.aws/credentials
                        sudo echo "aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" >>~/.aws/credentials
                    """
                 }
             }
         }
         stage('Install Dependencies') {
             steps {
                 sh 'make install'
                 sh 'make install hadolint'
             }
         }
         stage('Lint Dockerfile and Python') {
             steps {
                 sh 'make lint'
             }
         }
         stage('Build') {
             steps {
                 sh 'docker build --tag mtwatson/udacity-docker-milestone .'
             }
         }
         stage('Publish') {
            withDockerRegistry([ credentialsId: 'dockerhub', url: '' ]) {
              sh './upload_docker.sh'
            }
         }
         stage('Upload to AWS') {
              steps {
                  withAWS(region:'us-east-2',credentials:'aws-static') {
                  sh 'echo "Uploading content with AWS creds"'
                      s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'static-jenkins-pipeline')
                  }
              }
         }
     }
}