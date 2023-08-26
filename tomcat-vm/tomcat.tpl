#!/bin/bash
sudo apt update &&
sudo apt install default-jdk -y &&
wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.8/bin/apache-tomcat-10.0.8.tar.gz &&
sudo tar xzvf apache-tomcat-10.0.8.tar.gz &&
sudo mkdir /opt/tomcat/ &&
sudo mv apache-tomcat-10.0.8/* /opt/tomcat/ &&
sudo chown -R www-data:www-data /opt/tomcat/ &&
sudo chmod -R 755 /opt/tomcat/