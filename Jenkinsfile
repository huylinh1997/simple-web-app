pipeline {
    agent {
        docker {
            image 'your-docker-image:tag'
        }
    }

    stages {
        stage('Build Push Image') {
            steps {
                echo "============build image==========="
                // Use Docker credentials for authentication
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'your-docker-credentials-id', usernameVariable: 'DOCKER_REGISTRY_USERNAME', passwordVariable: 'DOCKER_REGISTRY_PASSWORD']]) {
                    // Build and push Docker image
                    sh "docker build -t dinhhuy1997/simple-app:v1 ."
                    sh "docker login -u \$DOCKER_REGISTRY_USERNAME -p \$DOCKER_REGISTRY_PASSWORD"
                    sh "docker push dinhhuy1997/simple-app:v1"
                }
            }
        }

        stage('Deploy Application') {
            steps {
                echo "============Deploy Application==========="
                sh "kubectl apply -f simpleapp.yaml"
            }
        }
    }

}