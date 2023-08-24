pipeline {
    agent any
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
        stage ('github checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Shivakumar1702/devops-002.git']])
            }
        }

        stage ('maven build') {
            steps {
                bat 'mvn -f app/pom.xml clean package'
            }
        }

        stage ('archive artifacts') {
            steps {
                archiveArtifacts artifacts: '**/*.war', followSymlinks: false
            }
        }

        stage ('deploy to vm') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://52.191.61.127:8080/')], contextPath: '/', war: '**/*.war'
            }
        }
    }

    post {
        success {
            echo 'deployment completed'
        }
    }
}
