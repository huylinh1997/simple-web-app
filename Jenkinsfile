pipeline {
    agent any

    stages {
        stage('Build Push Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        // Your Docker build and push steps here
                        echo "============build image==========="
                        def customImage = docker.build('simple-app:v1')
                        echo "============Push image==========="
                        customImage.push()
                    }
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