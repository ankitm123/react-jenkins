pipeline {
    agent {
        docker { image 'node:11.13.0-alpine' } // Could have used dockerfile instead of an image, but this is just a POC
    } // agent
    parameters {

        string(name: 'SLACK_CHANNEL',
            description: 'Default Slack channel to send messages to',
            defaultValue: '#jenkins-testing')

    } // parameters

    environment {

        // Slack configuration
        SLACK_COLOR_DANGER  = '#E01563'
        SLACK_COLOR_INFO    = '#6ECADC'
        SLACK_COLOR_WARNING = '#FFC300'
        SLACK_COLOR_GOOD    = '#3EB991'

    } // environment
    stages {
        stage('Check') {
            steps {
                script{
                    node --version
                    sh 'yarn --version'
                } // script
            } // steps
        } // stage Check
        stage('Install') {
            steps {
                script{
                    sh 'yarn install'
                } // script
            }// steps
        }// stage Install
        stage('Test') {
            steps {
                script{
                    sh 'yarn test'
                } // script
            }// steps
        }// stage Test
        stage('Build') {
            steps {
                script{
                    sh 'yarn build'
                // sh 'docker build -t ankitm123/cra-jenkins:latest .'
                // sh 'docker push ankitm123/cra-jenkins:latest'
                } // script
            } // steps
        } // stage build
    } //stages
    post {

        aborted {

        echo "Sending message to Slack"
        slackSend (color: "${env.SLACK_COLOR_WARNING}",
                    channel: "${params.SLACK_CHANNEL}",
                    message: "*ABORTED:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} by ${env.USER_ID}\n More info at: ${env.BUILD_URL}")
        } // aborted

        failure {

        echo "Sending message to Slack"
        slackSend (color: "${env.SLACK_COLOR_DANGER}",
                    channel: "${params.SLACK_CHANNEL}",
                    message: "*FAILED:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} by ${env.USER_ID}\n More info at: ${env.BUILD_URL}")
        } // failure

        success {
        echo "Sending message to Slack"
        slackSend (color: "${env.SLACK_COLOR_GOOD}",
                    channel: "${params.SLACK_CHANNEL}",
                    message: "*SUCCESS:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} by ${env.USER_ID}\n More info at: ${env.BUILD_URL}")
        } // success

  } // post
}