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
                        // def timestamp = sh(script: 'date +%s', returnStdout: true).trim()
                        // // Replace the timestamp placeholder in the template
                        // sh "sed 's/REPLACE_TIMESTAMP/$timestamp/' simpleapp-template.yaml > simpleapp.yaml"

                        // echo "============Deploy Application==========="
                        sh "kubectl apply -f simpleapp.yaml"
                        // kubectlApply configFile: 'simpleapp.yaml',namespace: 'default'
                    }
                }
            }
        }
    }

}