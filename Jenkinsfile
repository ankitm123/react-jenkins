pipeline {
    agent {
        docker { image 'node:11.13.0-alpine' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}