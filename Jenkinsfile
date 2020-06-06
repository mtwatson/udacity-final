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
         stage('Create EC2 Instance') {
             steps {
                 ansiblePlaybook playbook: 'main.yaml', inventory: 'inventory'
             }
         }
         stage('Build') {
             steps {
                 sh 'echo "Hello World"'
                 sh '''
                    echo "Multiline shell steps works too"
                     ls -lah
                 '''
             }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Security Scan') {
              steps { 
                 aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
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