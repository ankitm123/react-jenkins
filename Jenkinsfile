pipeline {
    agent {
        docker { image 'node:11.13.0-alpine' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'whoami'
                sh 'node --version'
                sh 'yarn --version'
                sh 'yarn install'
                sh 'yarn test'
            }
        }
    }
}