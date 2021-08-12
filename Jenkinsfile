pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                    withMaven {
                         sh "mvn clean verify"
                 } 
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
