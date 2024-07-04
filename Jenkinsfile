pipeline {
    agent any

    tools {
        maven 'maven:3.9.5'
      }

    environment {
        DOCKER_IMAGE_NAME = 'ecr/example/java'
        DOCKER_IMAGE_TAG = '1.0'
        SONAR_SCANNER = 'sonar-scanner'
        SONAR_SERVER = 'sonarqube'
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

        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool "${env.SONAR_SCANNER}"
            }

            steps {
                withSonarQubeEnv("${env.SONAR_SERVER}") {
                    sh 'mvn clean install'
                    sh "${scannerHome}/bin/sonar-scanner \
                                -Dsonar.projectKey=examplejava \
                                -Dsonar.projectName=examplejava \
                                -Dsonar.projectVersion=0.0.${BUILD_NUMBER} \
                                -Dsonar.sources=src \
                                -Dsonar.java.binaries=target/classes"
                }
            }
        }


//        stage('Test') {
//            steps {
//                sh 'mvn test'
                //sh 'echo Test'
//            }
//        }

//        stage('Build Docker image') {
//            steps {
//                script {
//                    docker.build("${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}")
//                    sh 'echo BUILD DOCKER IMAGE'
//                    sh 'docker images -a'
//               }
//            }
//        }

 //      stage('Scan Docker image') {
 //           steps {
 //               script {
                    // Run Trivy to scan the Docker image
 //                   def trivyOutput = sh(script: "trivy image ${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}", returnStdout: true).trim()

                    // Display Trivy scan results
//                    println trivyOutput

                    // Check if vulnerabilities were found
//                    if (trivyOutput.contains("Total: 0")) {
//                        echo "No vulnerabilities found in the Docker image."
//                    } else {
//                        echo "Vulnerabilities found in the Docker image."
                        // You can take further actions here based on your requirements
                        // For example, failing the build if vulnerabilities are found
                        // error "Vulnerabilities found in the Docker image."
//                   }
//                }
//            }
//        }
//        stage('Push Docker image') {
//            steps {
//                script {
//                    sh 'echo Docker Push to ECR'
//               }
//            }
//       }
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
