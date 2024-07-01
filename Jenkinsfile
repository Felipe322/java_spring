pipeline {
    agent any

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
        stage('List') {
            steps {
                sh 'ls -la'
                sh 'pwd'
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
