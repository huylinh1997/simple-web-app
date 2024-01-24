pipeline {
    agent {
        kubernetes {
            yamlFile 'builder.yaml'
        }
    }

    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM"){
            steps {
                git branch: 'cicd', credentialsId: 'github', url: 'https://github.com/huylinh1997/simple-web-app'
            }
        }

        stage('Build & Push with Kaniko') {
            steps {
                container(name: 'kaniko') {
                    script{
                        // /kaniko/executor --dockerfile `pwd`/Dockerfile \
                        //                  --context `pwd` \
                        //                  --destination=dinhhuy1997/simple-app:${BUILD_NUMBER}
                        sh '''
                            /kaniko/executor --dockerfile `pwd`/Dockerfile \
                                             --context `pwd` \
                                             --insecure \
                                             --skip-tls-verify \
                                            --destination harbor.local:30003/webapp/hello-kaniko:${BUILD_NUMBER}
                        '''
                        }
                    }
            }
        }

        stage('Deploy Application') {
            steps {
                container(name: 'kubectl') {
                    script {
                        // echo "============Deploy Application==========="
                        sh "kubectl apply -f simpleapp.yaml"
                    }
                }
            }
        }
    }

}