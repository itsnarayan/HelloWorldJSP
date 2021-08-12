pipeline {
    agent any
	tools {
    maven 'MAVEN_HOME'
  }
    stages {
        stage('Build') {
            steps {
                         sh "mvn clean install" 
                         sh 'cp /Users/01202794/.m2/repository/HelloWorldJSP/HelloWorldJSP/0.0.1-SNAPSHOT/HelloWorldJSP-0.0.1-SNAPSHOT.war /Users/01202794/.jenkins/workspace/HelloWorldJSP/HelloWorldJSP.war'
            }
        }
        stage('docker') {
         agent { dockerfile true }
            steps {
               sh 'docker ps'
               
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}