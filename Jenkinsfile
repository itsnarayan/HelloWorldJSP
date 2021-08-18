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
             	    sh 'docker build -t itsnarayankundgir/helloworldjsp:$BUILD_NUMBER -t itsnarayankundgir/helloworldjsp:latest .' 
            }
        }
       	stage('Push Image') {
           steps {
                // Pushing Integrated code to docker Hub"
                    sh 'docker image push --all-tags itsnarayankundgir/helloworldjsp'
                // Removing docker image from local"
                    sh 'docker image prune --force --all'
                
            }
        }
        
        stage('Deploy App') {
           steps {
                //Pulling latest docker Image with tag latest
                sh 'docker pull itsnarayankundgir/helloworldjsp:latest'  
		
                // Stop & Remove Current Container helloworldjsp-app
		sh 'docker stop helloworldjsp-app || true && docker rm helloworldjsp-app || true'
                    
                // Starting new Container helloworldjsp-app
                sh 'docker run -d -p 8081:8080 --name helloworldjsp-app itsnarayankundgir/helloworldjsp:latest'
		   
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
