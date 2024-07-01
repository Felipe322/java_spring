pipeline {
    agent any
    tools {
        maven 'maven:3.9.5'
        docker 'test'
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
                sh 'mvn test'
            }
        }

        stage('Build images') {
            steps {
                script {
                    sh 'node --version'
                }
            }
        }
        stage('Docker') {
            steps {
                script{
                    sh 'docker --version'
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
