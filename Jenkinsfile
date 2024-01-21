pipeline {
    agent any

    stages {
        stage('Build Push Image') {
            steps {
                // script {
                //     withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                //         // Your Docker build and push steps here
                //         echo "============build image==========="
                //         def customImage = docker.build('simple-app:v1')
                //         echo "============Push image==========="
                //         customImage.push()
                //     }
                // }
                echo "============build image==========="
                // Use Docker credentials for authentication
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_REGISTRY_USERNAME', passwordVariable: 'DOCKER_REGISTRY_PASSWORD']]) {
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