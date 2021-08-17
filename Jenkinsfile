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
               echo "Clone git Repository"
                    git branch: 'stage', url: 'https://github.com/itsnarayan/HelloWorldJSP.git'     
         	}
        }
  
        stage('Build Image') {
           steps {
               echo "Prepare WAR file of code package" 
            	    sh 'mvn package' 
            	    
               echo "Build Docker Image with latest change" 
             	    sh 'docker build --tag helloworldjsp:latest .' 
                    sh 'docker tag helloworldjsp itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'
            }
        }
       	stage('Push Image') {
           steps {
                echo "Pushing Integrated code to docker Hub"
                    sh 'docker image push itsnarayankundgir/helloworldjsp:$BUILD_NUMBER' 
                echo "Removing docker image from local"
                    sh 'docker image rm itsnarayankundgir/helloworldjsp:$BUILD_NUMBER' 
                
            }
        }
        
        stage('Deploy App') {
           steps {
                echo "Pulling latest docker Image with tag $BUILD_NUMBER"
                    sh 'docker pull itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'  
                
                echo "Fetching Current Running Container ID"
                    script {
                           CONTAINER_ID = sh(script: "docker ps | grep 'itsnarayankundgir/helloworldjsp' | awk '{ print \$1 }'", returnStdout: true)
                          echo "Current Running Container ID is $CONTAINER_ID"
                    }
                echo "Stopping Current Container $CONTAINER_ID"
                    sh "docker container stop $CONTAINER_ID"
                    sh "docker container rm $CONTAINER_ID"
                    
                echo  'Starting new Container'
                    sh 'docker run -d -p 8081:8080 itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'
                echo "Removing docker image from local"
                    sh 'docker image rm itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'
                
                echo "Fetching Newly deployed Container ID"
                    script {
                           NEW_CONTAINER_ID = sh(script: "docker ps | grep 'itsnarayankundgir/helloworldjsp' | awk '{ print \$1 }'", returnStdout: true)
                           echo "Newly Deployed Container ID is $NEW_CONTAINER_ID"
                    }
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
