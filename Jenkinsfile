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

        stage('Test') {
            steps {
                sh 'mvn test'
                //sh 'echo Test'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}")
                    sh 'echo BUILD DOCKER IMAGE'
                    sh 'docker images -a'
                }
            }
        }

       stage('Scan Docker image') {
            steps {
                script {
                    // Run Trivy to scan the Docker image
                    def trivyOutput = sh(script: "trivy image ${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}", returnStdout: true).trim()

                    // Display Trivy scan results
                    println trivyOutput

                    // Check if vulnerabilities were found
                    if (trivyOutput.contains("Total: 0")) {
                        echo "No vulnerabilities found in the Docker image."
                    } else {
                        echo "Vulnerabilities found in the Docker image."
                        // You can take further actions here based on your requirements
                        // For example, failing the build if vulnerabilities are found
                        // error "Vulnerabilities found in the Docker image."
                    }
                }
            }
        }
        stage('Push Docker image') {
            steps {
                script {
                    sh 'echo Docker Push to ECR'
                }
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
