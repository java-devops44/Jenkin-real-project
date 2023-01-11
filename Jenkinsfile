pipeline {
    
    agent any 
    
    stages {
        
        stage('Git Checkout'){
            
            steps{
                
                script{
                    
                    git branch: 'main', url: 'https://github.com/java-devops44/Jenkin-real-project.git'
                }
            }
        }
        stage('UNIT testing'){
            steps {

                script {

                    sh 'mvn test'
                }
            }
        }
        stage('Integration Testing'){
            steps{
                script{
                     sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('Maven Build'){
            steps{
                script{
                    sh 'mvn clean install'
                }            
            }
        }
        stage('Static Code Analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'jenkin-soanr') {
                        sh 'mvn clean package sonar:sonar'
                    }

                }
            }
        }
        stage('Quality Gates Status'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'jenkin-soanr'
                }
            }
        }
        stage('Upload to jar to Nexus-Repo'){
            steps{
                script{
                    def readPomVersion = readMavenPom file: 'pom.xml'

                    nexusArtifactUploader artifacts: [[artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar']], credentialsId: 'nexus-login', groupId: 'com.example', nexusUrl: '3.88.178.183:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'demoapp-release', version: "${readPomVersion.version}"

                }
            }
        }
        stage('Docker Build the Image'){
            steps{
                script{
                    sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID cloudhub12/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID cloudhub12/$JOB_NAME:latest'
                }
            }
        }
        stage('Docker Push to DockerHub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker-pass', variable: 'docker_HUB')]) {
                    sh 'docker login -u cloudhub12 -p ${docker_HUB}' 
                    sh 'docker image push cloudhub12/$JOB_NAME:v1.$BUILD_ID'   
                    sh 'docker image push cloudhub12/$JOB_NAME:latest'

                  }
                }
            }
        }
        
    }
}
