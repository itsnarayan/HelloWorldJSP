FROM tomcat:10.0.8-jdk16-openjdk
COPY target/HelloWorldJSP.war /usr/local/tomcat/webapps
EXPOSE 8081