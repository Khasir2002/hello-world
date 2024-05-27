pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        DOCKER_IMAGE = "your-dockerhub-username/hello-world"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    bat 'docker build -t %DOCKER_IMAGE%:%BUILD_NUMBER% .'
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    // Log in to Docker Hub
                    bat 'echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin'
                    // Push the Docker image to Docker Hub
                    bat 'docker push %DOCKER_IMAGE%:%BUILD_NUMBER%'
                }
            }
        }
        stage('Deploy to Minikube') {
            steps {
                script {
                    // Set up the Kubernetes deployment
                    bat """
                    kubectl set image deployment/hello-world hello-world=%DOCKER_IMAGE%:%BUILD_NUMBER% --record
                    kubectl rollout status deployment/hello-world
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
