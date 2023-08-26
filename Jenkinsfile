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

    parameters {
        CHOICE_PARAM (
            CHOICE_PARAMs: '''BUILDnPUSH\nCREATEVM\nDESTROYVM\nDEPLOY''',
            name: 'CHOICE_PARAM',
            description: 'select the action'

        )
    }
    
    stages {

        stage ('maven build'){
            when {
                expression {
                    CHOICE_PARAM == 'BUILDnPUSH'
                }
            }
            steps {
                bat "mvn clean package -f ./app/pom.xml"
            }
        }

        stage ('docker image build'){
            when {
                expression {
                    CHOICE_PARAM == 'BUILDnPUSH'
                }
            }
            steps {
                bat "docker image build -t shivakumar1702/tomcat:${env.BUILD_NUMBER} ."
            }
        }

        stage ('docker push'){
            when {
                expression {
                    CHOICE_PARAM == 'BUILDnPUSH'
                }
            }
            steps {
                bat "docker login -u ${env.DOCKERHUB_USR} -p ${env.DOCKERHUB_PSW}"
                bat "docker push shivakumar1702/tomcat:${env.BUILD_NUMBER}"
                bat "docker logout"
            }
        }

        stage ('remove local image'){
            when {
                expression {
                    CHOICE_PARAM == 'BUILDnPUSH'
                }
            }
            steps {
                bat "docker image rm shivakumar1702/tomcat:${env.BUILD_NUMBER}"
            }
        }

        stage ('terraform init'){
            when {
                expression {
                    CHOICE_PARAM == 'CREATEVM'
                }
            }
            steps {
                bat "terraform -chdir=tomcat-vm init"
            }
        }

        stage ('terraform plan'){
            when {
                expression {
                    CHOICE_PARAM == 'CREATEVM'
                }
            }
            steps {
                bat "terraform -chdir=tomcat-vm plan --out=plan.tfplan"
            }
        }

        stage ('terraform apply'){
            when {
                expression {
                    CHOICE_PARAM == 'CREATEVM'
                }
            }
            steps {
                bat "terraform -chdir=tomcat-vm apply plan.tfplan -auto-approve"
            }
        }

        stage ('terraform destroy'){
            when {
                expression {
                    CHOICE_PARAM == 'DESTROYVM'
                }
            }
            steps {
                bat "terraform -chdir=tomcat-vm destroy plan.tfplan -auto-approve"
            }
        }
    }
}