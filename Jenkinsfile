pipeline {
    agent any
    environment {
        DOCKERHUB = credentials('dockerhub')
    }

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '2', daysToKeepStr: '2'))
        disableConcurrentBuilds()
    }

    tools {
        jdk 'JAVA'
        maven 'maven'
    }
    
    stages {

        stage ('maven build'){
            steps {
                bat "mvn clean package -f ./app/pom.xml"
            }
        }

        stage ('docker image build'){
            steps {
                bat "docker image build -t shivakumar1702/tomcat:${env.BUILD_NUMBER} ."
            }
        }

        stage ('docker push'){
            steps {
                bat "docker login -u ${env.DOCKERHUB_USR} -p ${env.DOCKERHUB_PSW}"
                bat "docker push shivakumar1702/tomcat:${env.BUILD_NUMBER}"
                bat "docker logout"
            }
        }

        stage ('remove local image'){
            steps {
                bat "docker image rm shivakumar1702/tomcat:${env.BUILD_NUMBER}"
            }
        }
    }
}