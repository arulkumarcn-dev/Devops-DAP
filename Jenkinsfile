pipeline {
    agent any
    
    environment {
        // ArulKumar's DevOps Assignment Environment Variables
        APP_NAME = 'arulkumar-devops-app'
        DEVELOPER_NAME = 'ArulKumar'
        MAVEN_HOME = tool 'Maven'
        JAVA_HOME = tool 'JDK17'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '========================================='
                echo 'Stage 1: Checkout - ArulKumar'
                echo '========================================='
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo '========================================='
                echo 'Stage 2: Build - ArulKumar'
                echo '========================================='
                script {
                    if (isUnix()) {
                        sh 'mvn clean package -DskipTests'
                    } else {
                        bat 'mvn clean package -DskipTests'
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                echo '========================================='
                echo 'Stage 3: Test - ArulKumar'
                echo '========================================='
                script {
                    if (isUnix()) {
                        sh 'mvn test'
                    } else {
                        bat 'mvn test'
                    }
                }
            }
        }
        
        stage('Package') {
            steps {
                echo '========================================='
                echo 'Stage 4: Package - ArulKumar'
                echo '========================================='
                script {
                    if (isUnix()) {
                        sh 'mvn package'
                    } else {
                        bat 'mvn package'
                    }
                }
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                echo '========================================='
                echo 'Stage 5: Archive Artifacts - ArulKumar'
                echo '========================================='
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        
        stage('Docker Build') {
            steps {
                echo '========================================='
                echo 'Stage 6: Docker Build - ArulKumar'
                echo '========================================='
                script {
                    if (isUnix()) {
                        sh "docker build -t ${APP_NAME}:latest ."
                        sh "docker tag ${APP_NAME}:latest ${APP_NAME}:${BUILD_NUMBER}"
                    } else {
                        bat "docker build -t ${APP_NAME}:latest ."
                        bat "docker tag ${APP_NAME}:latest ${APP_NAME}:${BUILD_NUMBER}"
                    }
                }
            }
        }
        
        stage('Post-Build Report') {
            steps {
                echo '========================================='
                echo 'Build completed by: ArulKumar'
                echo "Build Number: ${BUILD_NUMBER}"
                echo "Application: ${APP_NAME}"
                echo '========================================='
            }
        }
    }
    
    post {
        success {
            echo '========================================='
            echo 'SUCCESS: ArulKumar DevOps Build Successful!'
            echo '========================================='
        }
        failure {
            echo '========================================='
            echo 'FAILURE: Build Failed - ArulKumar'
            echo '========================================='
        }
        always {
            echo 'Build Pipeline Completed - ArulKumar'
            cleanWs()
        }
    }
}
