pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t davishm26/nama-repo-proyek:latest .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    bat 'docker login -u %USER% -p %PASS%'
                    bat 'docker push davishm26/nama-repo-proyek:latest'
                }
            }
        }
    }
}
