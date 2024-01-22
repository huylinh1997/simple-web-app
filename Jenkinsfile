pipeline {
    agent {
        kubernetes {
      yaml """
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: docker-credentials 
          items:
            - key: .dockerconfigjson
              path: config.json
"""
        }
    }

    environment {
        APP_NAME = "simple-app"
        RELEASE = "1.0.0"
        DOCKER_USER = "dinhhuy1997"
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
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

        // stage('Build & Push with Kaniko') {
        //     steps {
        //         container(name: 'kaniko', shell: '/busybox/sh') {
        //         sh '''#!/busybox/sh
        //             /kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination=${IMAGE_NAME}:${IMAGE_TAG} --destination=${IMAGE_NAME}:latest
        //         '''
        //         }
        //     }
        // }

        stage('Install kubectl') {
            steps {
                script {
                    // Download and install kubectl
                    sh 'curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'
                    sh 'chmod +x kubectl'
                    sh 'sudo mv kubectl /usr/local/bin/'

                    // Verify kubectl installation
                    sh 'kubectl version --client'
                }
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    def timestamp = sh(script: 'date +%s', returnStdout: true).trim()
                    // Replace the timestamp placeholder in the template
                    sh "sed 's/REPLACE_TIMESTAMP/$timestamp/' simpleapp-template.yaml > simpleapp.yaml"

                    echo "============Deploy Application==========="
                    sh "kubectl apply -f simpleapp.yaml"
                }
            }
        }
    }

}