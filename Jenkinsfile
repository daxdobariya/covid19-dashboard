pipeline {
    agent{
        label 'W1'
    }

    environment {
        DOCKER_IMAGE = "daxdobariya/covid19-dashboard"
        CONTAINER_NAME = "covid19-dashboard"
        GIT_URL = "https://github.com/daxdobariya/covid19-dashboard.git"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Fetching code from GitHub..."
                git branch: 'main', url: "${GIT_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh """
                    docker build -t ${DOCKER_IMAGE}:latest .
                """
            }
        }

        stage('Remove Old Container') {
            steps {
                echo "Removing old container if running..."
                sh """
                    if [ \$(docker ps -aq -f name=${CONTAINER_NAME}) ]; then
                        docker rm -f ${CONTAINER_NAME} || true
                    fi
                """
            }
        }

        stage('Run New Container') {
            steps {
                echo "Starting new container..."
                sh """
                    docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${DOCKER_IMAGE}:latest
                """
            }
        }
    }

    post {
        success {
            echo "Deployment successful! Application running on port 8000."
        }
        failure {
            echo "Build or deployment failed."
        }
    }
}
