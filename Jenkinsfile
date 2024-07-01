pipeline {
    agent any

    //tools {
      //  maven 'maven:3.9.5'
    //}

    environment {
        DOCKER_IMAGE_NAME = 'ecr/example/java'
        DOCKER_IMAGE_TAG = '1.0'
    }
    
    options {
        // disableConcurrentBuilds() 
        timeout(time: 15, unit: 'MINUTES')
    }

    stages {
        stage('Clone repositorio') {
            steps {
                checkout scm
            }
        }
        stage('Test') {
            steps {
                //sh 'mvn test'
                sh 'echo Test'
            }
        }

        stage('Build Docker images') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}")
                    sh 'docker images -a'
                }
            }
        }
    }

    post {
        always {
            echo 'Ejecución completada'
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
