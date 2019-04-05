pipeline {
    agent { dockerfile true }
    parameters {

        string(name: 'SLACK_CHANNEL',
            description: 'Default Slack channel to send messages to',
            defaultValue: '#jenkins-testing')

    } // parameters

    environment {

        // Slack configuration
        SLACK_COLOR_DANGER  = '#E01563'
        SLACK_COLOR_WARNING = '#FFC300'
        SLACK_COLOR_GOOD    = '#3EB991'

    } // environment
    stages {
        stage('Check') {
            steps {
                script{
                    sh 'node --version'
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
                    
                } // script
            } // steps
        } // stage build

        stage('Docker') {
            steps {
                script{
                    // Need to login first into docker hub, probably pass credentials in jenkins configuration
                    sh 'cat /password.txt | docker login --username ankitm1234 --password-stdin'
                    sh 'make dockerpush'
                } // script
            } // steps
        } // stage docker
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
} // pipeline