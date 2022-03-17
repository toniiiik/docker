FROM tomcat:8.5-jdk11-openjdk
LABEL MAINTAINER Karl Dahlgren <karl.dahlgren@castlemock.com>

# Delete the default applications
RUN rm -rf /usr/local/tomcat/webapps/ROOT
RUN rm -rf /usr/local/tomcat/webapps/docs
RUN rm -rf /usr/local/tomcat/webapps/examples
RUN rm -rf /usr/local/tomcat/webapps/manager
RUN rm -rf /usr/local/tomcat/webapps/host-manager

# Change directory to Tomcat webapps folder and download the latest Castle Mock war file
RUN mkdir -p /usr/local/tomcat/webapps/castlemock && cd /usr/local/tomcat/webapps/castlemock \
    && curl -o castlemock.war -fSL https://github.com/castlemock/castlemock/releases/download/v1.63/castlemock.war \
    && jar -xvf castlemock.war \
    && rm -f castlemock.war

ADD ./libs/ /usr/local/tomcat/webapps/castlemock/WEB-INF/lib/

# Expose HTTP port 8080
EXPOSE 8080
