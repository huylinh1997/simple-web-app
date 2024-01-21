pipeline {
    agent any

    stages {
        stage('Build Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry-1.docker.io', 'dockerhub') {
                        // Your Docker build and push steps here
                        echo "============build image==========="
                        def customImage = docker.build('simple-app:v1')
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