pipeline {
    agent any

    environment {
        TARGET_HOST = '15.152.32.150'
        SSH_USER = 'ec2-user'
        SSH_CREDENTIALS_ID = 'ec2-access'
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/vaibhav0060/nginx-deploy.git'
            }
        }

        stage('Approval Before Deployment') {
            steps {
                script {
                    input message: 'Do you approve deployment to EC2?', ok: 'Yes, Deploy'
                }
            }
        }

        stage('Deploy to EC2 Instance') {
            steps {
                sshagent (credentials: [env.SSH_CREDENTIALS_ID]) {
                    sh """
                        echo "Copying files to EC2..."
                        scp -o StrictHostKeyChecking=no -r * ${SSH_USER}@${TARGET_HOST}:/home/${SSH_USER}/app

                        echo "Running deployment script on EC2..."
                        ssh -o StrictHostKeyChecking=no ${SSH_USER}@${TARGET_HOST} 'bash /home/${SSH_USER}/app/app.sh'
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully.'
        }
        failure {
            echo '❌ Deployment failed.'
        }
    }
}
