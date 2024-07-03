pipeline {
    agent any

    tools {
        maven 'maven:3.9.5'
    }

    environment {
        DOCKER_IMAGE_NAME = 'ecr/example/java'
        DOCKER_IMAGE_TAG = '1.0'
    }
    
    options {
        disableConcurrentBuilds() 
        timeout(time: 15, unit: 'MINUTES')
    }

    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Clone repositorio') {
            steps {
                checkout scm
            }
        }

        stage('Sonar') {
            steps {
                sh 'mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=Ejemplo-java \
                    -Dsonar.projectName='Ejemplo-java' \
                    -Dsonar.host.url=http://sonarqube:9000 \
                    -Dsonar.token=sqp_181431c0d6f4c7453c8700134cbdd34e5d22ad6c'
            }
        }
    }

    post {
        always {
            echo 'Ejecución completada.'
            cleanWs()
        }
        success {
            echo 'El pipeline se ejecutó con éxito.'
        }
        failure {
            echo 'El pipeline falló.'
        }
    }
}
