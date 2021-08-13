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
                sh 'docker image rm itsnarayankundgir/helloworldjsp:$BUILD_NUMBER' 
                
          }
        }
        
        stage('Docker Pull and Run') {
           steps {
                sh 'docker pull itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'       
          }
        }
        
        stage('Docker Run') {
           steps {   
                //stop existing container
                	//fetch container ID by Image name
                def runningContainerID = sh	'docker ps | grep \'itsnarayankundgir/helloworldjsp\' | awk \'{ print $1 }\''
            
                sh 'docker container stop $runningContainerID'
              
              //Run latest image
                sh 'docker run -d -p 8081:8080 itsnarayankundgir/helloworldjsp:$BUILD_NUMBER'   
          }
        }
       
    }
}