pipeline {
    agent any

    environment {
        DOCKER = 'image:test'
    }

    options {
        disableConcurrentBuilds() 
        timeout(time: 15, unit: 'MINUTES')
    }

    stages {

        stage('Build Docker image') {
            steps {
                script {
                    docker.build("${env.DOCKER}")
                    sh 'docker images -a'
               }
            }
        }

        stage('Scan Docker image') {
            steps {
                script {
                    def trivyOutput = sh(script: "trivy image ${env.DOCKER}", returnStdout: true).trim()
                    println trivyOutput

                    if (trivyOutput.contains("Total: 0")) {
                        echo "No vulnerabilities found in the Docker image."
                    } else {
                        echo "Vulnerabilities found in the Docker image."
                   }
                }
            }
        }

    }

    post {
            always {
                // Limpiar recursos después del pipeline
                sh "docker rmi ${env.DOCKER}"
                cleanWs()
            }
        }
}
