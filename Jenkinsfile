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
                }            }
        }
    }
}