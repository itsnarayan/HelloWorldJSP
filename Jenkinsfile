pipeline {
    agent any
	tools {
    maven 'MAVEN_HOME'
  }
  
   stages {
      stage('checkout') {
           steps {  
                git branch: 'stage', url: 'https://github.com/itsnarayan/HelloWorldJSP.git'     
         	 }
        }

        stage('Execute Maven') {
            steps {
            	sh 'mvn package'          
            }
        }
        
        stage('Docker Build and Tag') {
           steps {
             	sh 'docker build --tag helloworldjsp:latest .' 
                sh 'docker tag helloworldjsp itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'
          }
        }
       	stage('Docker Push') {
           steps {

                sh 'docker image push itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'       
          }
        }
       
    }
}