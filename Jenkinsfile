def CONTAINER_ID
def NEW_CONTAINER_ID

pipeline {
    agent any
	tools {
    maven 'MAVEN_HOME'
  }
   
    stages {
        stage('Code Checkout') {
           steps {  
               // Clone git Repository
                    git branch: 'stage', url: 'https://github.com/itsnarayan/HelloWorldJSP.git'     
         	}
        }
  
        stage('Build Image') {
           steps {
               // Prepare WAR file of code package
            	    sh 'mvn package' 
            	    
               // Build Docker Image with latest change
             	    sh 'docker build --tag helloworldjsp:latest .' 
                    sh 'docker tag helloworldjsp itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'
            }
        }
       	stage('Push Image') {
           steps {
                // Pushing Integrated code to docker Hub"
                    sh 'docker image push itsnarayankundgir/helloworldjsp:$BUILD_NUMBER' 
                // Removing docker image from local"
                    sh 'docker image rm itsnarayankundgir/helloworldjsp:$BUILD_NUMBER' 
                
            }
        }
        
        stage('Deploy App') {
           steps {
                //Pulling latest docker Image with tag $BUILD_NUMBER
                sh 'docker pull itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'  
		
                // Stop & Remove Current Container helloworldjsp-app
		sh 'docker stop helloworldjsp-app || true && docker rm helloworldjsp-app || true'
                    
                // Starting new Container helloworldjsp-app
                sh 'docker run -d -p 8081:8080 --name helloworldjsp-app itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'
                
                // Removing docker image from local
                sh 'docker image rm itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'
		   
                echo "Application Deployed Successfully"
                echo "Access App using this URL http://localhost:8081/HelloWorldJSP/helloWorld.jsp"
            }
        }
    }
    post {
        // Clean after build
        always {
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
        }
    }
}
