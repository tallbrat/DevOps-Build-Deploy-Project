FROM tomcat:jre17-temurin
WORKDIR /webapp
COPY /target/*.jar .
EXPOSE 8080
CMD ["/bin/catalina.sh", "RUN"]
