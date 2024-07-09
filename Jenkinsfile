pipeline {
    agent any

    //tools {
      //  maven 'maven:3.9.5'
      //}

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
        stage('Test') {
            steps {
                //sh 'mvn test'
                sh 'echo Test'
            }
        }

        //stage('SonarQube Analysis') {
         //   environment {
           //     scannerHome = tool "${env.SONAR_SCANNER}"
            //}

            //steps {
              //  withSonarQubeEnv("${env.SONAR_SERVER}") {
                //    sh 'mvn clean install'
                  //  sh "${scannerHome}/bin/sonar-scanner \
                     //           -Dsonar.projectKey=examplejava \
                      //          -Dsonar.projectName=examplejava \
                      //          -Dsonar.projectVersion=0.0.${BUILD_NUMBER} \
                      //          -Dsonar.sources=src \
                       //         -Dsonar.java.binaries=target/classes"
                //}
            //}
        //}

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
                    def trivyOutput = sh(script: "trivy image ${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}", returnStdout: true).trim()
                    println trivyOutput

                    if (trivyOutput.contains("Total: 0")) {
                        echo "No vulnerabilities found in the Docker image."
                    } else {
                        echo "Vulnerabilities found in the Docker image."
                   }
                }
            }
        }

        stage('Download_WizCLI') {
            steps {
                // Download_WizCLI
                sh 'echo "Downloading wizcli..."'
                sh 'curl -o wizcli https://downloads.wiz.io/wizcli/latest/wizcli-linux-amd64'
                sh 'chmod +x wizcli'
            } 
        }
        stage('Auth_With_Wiz') {
            steps {
                // Auth with Wiz
                sh 'echo "Authenticating to the Wiz API..."'
                withCredentials([usernamePassword(credentialsId: 'wizcli', usernameVariable: 'ID', passwordVariable: 'SECRET')]) {
                sh './wizcli auth --id $ID --secret $SECRET'}
            }
        }
        stage('Scan') {
            steps {
                // Scanning the image
                sh 'echo "Scanning the image using wizcli..."'
                sh './wizcli docker scan --image ecr/example/java:1.0'
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
