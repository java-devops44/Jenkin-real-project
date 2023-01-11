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
                    def nexusrepo = readPomVersion.version.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp-release"
                    nexusArtifactUploader artifacts: [[artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar']], credentialsId: 'nexus-login', groupId: 'com.example', nexusUrl: '3.88.178.183:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'nexusrepo', version: "${readPomVersion.version}"

                }
            }
        }
        
    }
}
