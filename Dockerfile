FROM tomcat:latest
WORKDIR /usr/local/tomcat
COPY app/target/app.war ./webapps
RUN cp -r ./webapps.dist/* ./webapps/
EXPOSE 8080

