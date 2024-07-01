pipeline {
    agent any

    tools {
        maven 'maven:3.9.5'
    }
    
    options {
        // Cancelar builds viejos en cola
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
    }

    post {
        // Bloque post para acciones post-ejecución
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
