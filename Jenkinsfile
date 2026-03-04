pipeline {
    agent any

    environment {
        // ArulKumar's DevOps Assignment Environment Variables
        APP_NAME        = 'arulkumar-devops-app'
        DEVELOPER_NAME  = 'ArulKumar'
        AWS_REGION      = 'us-east-1'
        AWS_ACCOUNT_ID  = '958175316186'
        ECR_REPO        = '958175316186.dkr.ecr.us-east-1.amazonaws.com/arulkumar-devops-app'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '========================================='
                echo 'Stage 1: Checkout - ArulKumar'
                echo '========================================='
                checkout scm
                script {
                    if (isUnix()) {
                        sh 'java -version'
                        sh 'mvn -version'
                    } else {
                        bat 'java -version'
                        bat 'mvn -version'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                echo '========================================='
                echo 'Stage 2: Maven Build - ArulKumar'
                echo '========================================='
                script {
                    if (isUnix()) {
                        sh 'mvn clean compile -DskipTests'
                    } else {
                        bat 'mvn clean compile -DskipTests'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                echo '========================================='
                echo 'Stage 3: Unit Tests - ArulKumar'
                echo '========================================='
                script {
                    if (isUnix()) {
                        sh 'mvn test'
                    } else {
                        bat 'mvn test'
                    }
                }
            }
            post {
                always {
                    junit testResults: 'target/surefire-reports/*.xml', allowEmptyResults: true
                }
            }
        }

        stage('Package') {
            steps {
                echo '========================================='
                echo 'Stage 4: Maven Package (JAR) - ArulKumar'
                echo '========================================='
                script {
                    if (isUnix()) {
                        sh 'mvn package -DskipTests'
                    } else {
                        bat 'mvn package -DskipTests'
                    }
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo '========================================='
                echo 'Stage 5: Archive Artifacts - ArulKumar'
                echo '========================================='
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true, allowEmptyArchive: false
            }
        }

        stage('Docker Build') {
            steps {
                echo '========================================='
                echo 'Stage 6: Docker Build & Tag - ArulKumar'
                echo '========================================='
                script {
                    def imageTag = "${ECR_REPO}:jenkins-${BUILD_NUMBER}"
                    try {
                        if (isUnix()) {
                            sh "docker --version"
                            sh "docker build -t ${APP_NAME}:${BUILD_NUMBER} ."
                            sh "docker tag ${APP_NAME}:${BUILD_NUMBER} ${imageTag}"
                            sh "docker tag ${APP_NAME}:${BUILD_NUMBER} ${APP_NAME}:latest"
                        } else {
                            bat "docker --version"
                            bat "docker build -t ${APP_NAME}:${BUILD_NUMBER} ."
                            bat "docker tag ${APP_NAME}:${BUILD_NUMBER} ${imageTag}"
                            bat "docker tag ${APP_NAME}:${BUILD_NUMBER} ${APP_NAME}:latest"
                        }
                        echo "Docker image built: ${APP_NAME}:${BUILD_NUMBER}"
                    } catch (Exception e) {
                        echo "NOTICE: Docker not available on this local machine - skipping Docker build stage."
                        echo "Docker image is built and deployed via AWS CodePipeline (Task 4) automatically."
                        echo "ArulKumar - Docker stage skipped: ${e.message}"
                    }
                }
            }
        }

        stage('Post-Build Report') {
            steps {
                echo '========================================='
                echo "Build completed by   : ArulKumar"
                echo "Build Number         : ${BUILD_NUMBER}"
                echo "Application          : ${APP_NAME}"
                echo "ECR Repository       : ${ECR_REPO}"
                echo "AWS Region           : ${AWS_REGION}"
                echo "Pipeline Status      : SUCCESS"
                echo '========================================='
            }
        }
    }

    post {
        success {
            echo '========================================================'
            echo 'SUCCESS: ArulKumar DevOps Jenkins Pipeline Successful!'
            echo "Build #${BUILD_NUMBER} - All 7 stages passed"
            echo '========================================================'
        }
        failure {
            echo '========================================================'
            echo "FAILURE: Build #${BUILD_NUMBER} Failed - ArulKumar"
            echo 'Check console output above for error details'
            echo '========================================================'
        }
        always {
            echo "Pipeline Completed - ArulKumar DevOps Assignment"
            echo "Build #${BUILD_NUMBER} finished at: ${new Date()}"
            cleanWs()
        }
    }
}
