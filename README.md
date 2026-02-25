# DevOps Sharpened DAP Completion Assignment

## 👨‍💻 Developer: ArulKumar

![Status](https://img.shields.io/badge/Status-Complete-success)
![Developer](https://img.shields.io/badge/Developer-ArulKumar-blue)
![Java](https://img.shields.io/badge/Java-17-orange)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.0-green)
![Docker](https://img.shields.io/badge/Docker-Enabled-blue)
![AWS](https://img.shields.io/badge/AWS-ECS%20%7C%20ECR-orange)

---

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Assignment Requirements](#assignment-requirements)
3. [Technologies Used](#technologies-used)
4. [Project Structure](#project-structure)
5. [Setup Instructions](#setup-instructions)
6. [Jenkins Pipeline Setup](#jenkins-pipeline-setup)
7. [Docker Setup](#docker-setup)
8. [AWS ECS & ECR Setup](#aws-ecs--ecr-setup)
9. [AWS CodePipeline Setup](#aws-codepipeline-setup)
10. [CloudFormation Deployment](#cloudformation-deployment)
11. [API Endpoints](#api-endpoints)
12. [Testing](#testing)
13. [Troubleshooting](#troubleshooting)

---

## 🎯 Project Overview

This is a complete DevOps CI/CD implementation created by **ArulKumar** as part of the DevOps Sharpened DAP Completion Assignment. The project demonstrates a full-stack DevOps pipeline including:

- ✅ SpringBoot RESTful Application
- ✅ Jenkins CI/CD Pipeline
- ✅ Docker Containerization
- ✅ AWS ECR (Elastic Container Registry)
- ✅ AWS ECS (Elastic Container Service)
- ✅ AWS CodePipeline
- ✅ CloudFormation Infrastructure as Code

**Created by:** ArulKumar  
**Date:** February 2026  
**Version:** 1.0.0

---

## 📝 Assignment Requirements

### Requirement 1: SpringBoot Application ✅
Created a SpringBoot application with REST endpoints hosted on GitHub.

### Requirement 2: Jenkins Pipeline ✅
Configured Jenkins pipeline to:
- Pull code from GitHub
- Build the application using Maven
- Create Docker images
- Archive artifacts

### Requirement 3: AWS ECR & ECS Deployment ✅
- Build Docker image
- Push to AWS ECR
- Deploy as container on AWS ECS
- Accessible via Application Load Balancer

### Requirement 4: AWS CodePipeline ✅
- Complete CI/CD pipeline
- Automated build and deployment
- Includes buildspec.yml and Dockerfile

### Requirement 5: CloudFormation Template ✅
- Infrastructure as Code
- Complete pipeline setup using CloudFormation

---

## 🛠 Technologies Used

| Technology | Version | Purpose |
|------------|---------|---------|
| Java | 17 | Programming Language |
| Spring Boot | 3.2.0 | Application Framework |
| Maven | 3.9+ | Build Tool |
| Docker | Latest | Containerization |
| Jenkins | Latest | CI/CD Pipeline |
| AWS ECR | N/A | Container Registry |
| AWS ECS | Fargate | Container Orchestration |
| AWS CodePipeline | N/A | CI/CD Service |
| CloudFormation | N/A | Infrastructure as Code |

---

## 📁 Project Structure

```
arulkumar-devops-assignment/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/arulkumar/devops/
│       │       ├── DevOpsApplication.java
│       │       └── controller/
│       │           └── HealthController.java
│       └── resources/
│           └── application.properties
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── buildspec.yml
├── cloudformation-pipeline.yaml
├── ecs-task-definition.json
├── aws-commands.ps1
├── pom.xml
├── .gitignore
├── .dockerignore
└── README.md
```

---

## 🚀 Setup Instructions

### Prerequisites
- Java 17 installed
- Maven 3.9+ installed
- Docker installed
- AWS CLI configured
- Jenkins installed (for local pipeline)
- GitHub account
- AWS account

### 1. Clone the Repository
```bash
git clone https://github.com/arulkumar/devops-assignment.git
cd devops-assignment
```

### 2. Build the Application
```bash
mvn clean package
```

### 3. Run Locally
```bash
java -jar target/arulkumar-devops-app.jar
```

Access the application at: `http://localhost:8080`

---

## 🔧 Jenkins Pipeline Setup

### Step 1: Install Jenkins
```bash
# Download and install Jenkins from jenkins.io
# Windows: Use MSI installer
# Linux: Use package manager
```

### Step 2: Install Required Plugins
- Git Plugin
- Maven Integration Plugin
- Docker Plugin
- Pipeline Plugin

### Step 3: Configure Tools
1. Go to **Manage Jenkins** → **Global Tool Configuration**
2. Configure:
   - JDK 17 (name: `JDK17`)
   - Maven 3.9+ (name: `Maven`)
   - Docker

### Step 4: Create Pipeline Job
1. New Item → Pipeline
2. Name: `ArulKumar-DevOps-Pipeline`
3. Pipeline Definition: **Pipeline script from SCM**
4. SCM: **Git**
5. Repository URL: `https://github.com/arulkumar/devops-assignment.git`
6. Script Path: `Jenkinsfile`

### Step 5: Run the Pipeline
Click **Build Now** and monitor the console output.

**Pipeline Stages:**
1. ✅ Checkout - Pull code from GitHub
2. ✅ Build - Compile application with Maven
3. ✅ Test - Run unit tests
4. ✅ Package - Create JAR file
5. ✅ Archive - Store artifacts
6. ✅ Docker Build - Create Docker image

---

## 🐳 Docker Setup

### Build Docker Image
```bash
docker build -t arulkumar-devops-app:latest .
```

### Run Container Locally
```bash
docker run -d -p 8080:8080 --name arulkumar-container arulkumar-devops-app:latest
```

### Using Docker Compose
```bash
docker-compose up -d
```

### Test the Container
```bash
curl http://localhost:8080/api/health
curl http://localhost:8080/api/welcome
```

### Stop and Remove
```bash
docker stop arulkumar-container
docker rm arulkumar-container
```

---

## ☁️ AWS ECS & ECR Setup

### Step 1: Create ECR Repository
```bash
aws ecr create-repository \
    --repository-name arulkumar-devops-app \
    --region us-east-1 \
    --tags Key=Developer,Value=ArulKumar
```

### Step 2: Login to ECR
```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com
```

### Step 3: Tag and Push Image
```bash
docker tag arulkumar-devops-app:latest <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/arulkumar-devops-app:latest
docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/arulkumar-devops-app:latest
```

### Step 4: Create ECS Cluster
```bash
aws ecs create-cluster \
    --cluster-name arulkumar-devops-cluster \
    --region us-east-1 \
    --tags Key=Developer,Value=ArulKumar
```

### Step 5: Register Task Definition
```bash
aws ecs register-task-definition \
    --cli-input-json file://ecs-task-definition.json \
    --region us-east-1
```

### Step 6: Create ECS Service
```bash
aws ecs create-service \
    --cluster arulkumar-devops-cluster \
    --service-name arulkumar-devops-service \
    --task-definition arulkumar-devops-app \
    --desired-count 1 \
    --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[subnet-xxxxx],securityGroups=[sg-xxxxx],assignPublicIp=ENABLED}" \
    --region us-east-1
```

### Step 7: Access the Application
Once deployed, access the application via the Load Balancer DNS name or public IP.

---

## 🚀 AWS CodePipeline Setup

### Prerequisites
- GitHub Personal Access Token
- S3 Bucket for artifacts
- IAM Roles configured

### Step 1: Create S3 Bucket
```bash
aws s3 mb s3://arulkumar-devops-artifacts
```

### Step 2: Create CodeBuild Project
1. Go to AWS CodeBuild Console
2. Create Build Project:
   - Name: `arulkumar-devops-build`
   - Source: GitHub
   - Buildspec: `buildspec.yml`
   - Environment: Standard Linux, Docker enabled

### Step 3: Create CodePipeline
1. Go to AWS CodePipeline Console
2. Create Pipeline:
   - Name: `arulkumar-devops-pipeline`
   - Source: GitHub
   - Build: CodeBuild project
   - Deploy: Amazon ECS

### Step 4: Test the Pipeline
Push changes to GitHub and watch the pipeline execute automatically.

---

## 📦 CloudFormation Deployment

### Deploy Complete Infrastructure
```bash
aws cloudformation create-stack \
    --stack-name arulkumar-devops-stack \
    --template-body file://cloudformation-pipeline.yaml \
    --parameters \
        ParameterKey=GitHubToken,ParameterValue=<YOUR_TOKEN> \
        ParameterKey=GitHubUser,ParameterValue=arulkumar \
        ParameterKey=GitHubRepo,ParameterValue=devops-assignment \
    --capabilities CAPABILITY_NAMED_IAM \
    --region us-east-1 \
    --tags Key=Developer,Value=ArulKumar
```

### Check Stack Status
```bash
aws cloudformation describe-stacks \
    --stack-name arulkumar-devops-stack \
    --query 'Stacks[0].StackStatus'
```

### Get Outputs
```bash
aws cloudformation describe-stacks \
    --stack-name arulkumar-devops-stack \
    --query 'Stacks[0].Outputs'
```

### Delete Stack (if needed)
```bash
aws cloudformation delete-stack \
    --stack-name arulkumar-devops-stack
```

---

## 🔌 API Endpoints

### Health Check
```bash
GET /api/health
```
**Response:**
```json
{
  "status": "UP",
  "application": "ArulKumar DevOps Assignment",
  "author": "ArulKumar",
  "timestamp": "2026-02-25T10:30:00",
  "message": "Application is running successfully!"
}
```

### Welcome
```bash
GET /api/welcome
```
**Response:**
```json
{
  "message": "Welcome to ArulKumar's DevOps Assignment!",
  "assignment": "DevOps Sharpened DAP Completion",
  "author": "ArulKumar",
  "features": [
    "Jenkins Pipeline Integration",
    "Docker Containerization",
    "AWS ECR & ECS Deployment",
    "AWS CodePipeline CI/CD",
    "CloudFormation Infrastructure as Code"
  ]
}
```

### Application Info
```bash
GET /api/info
```
**Response:**
```json
{
  "projectName": "ArulKumar DevOps Assignment",
  "developer": "ArulKumar",
  "version": "1.0.0",
  "description": "SpringBoot application with complete CI/CD pipeline",
  "technologies": [
    "Spring Boot 3.2.0",
    "Java 17",
    "Docker",
    "Jenkins",
    "AWS ECR",
    "AWS ECS",
    "AWS CodePipeline",
    "CloudFormation"
  ]
}
```

---

## 🧪 Testing

### Test Locally
```bash
# Build and run
mvn spring-boot:run

# Test endpoints
curl http://localhost:8080/api/health
curl http://localhost:8080/api/welcome
curl http://localhost:8080/api/info
```

### Test Docker Container
```bash
docker run -d -p 8080:8080 arulkumar-devops-app:latest
curl http://localhost:8080/api/health
```

### Test on AWS
```bash
# Replace with your Load Balancer DNS
curl http://<ALB-DNS>/api/health
curl http://<ALB-DNS>/api/welcome
```

---

## 🔍 Troubleshooting

### Jenkins Build Fails
- Verify Java 17 and Maven are configured
- Check GitHub credentials
- Ensure Docker is running

### Docker Image Build Fails
- Check Dockerfile syntax
- Verify Maven build succeeds first
- Ensure port 8080 is not in use

### AWS Deployment Issues
- Verify AWS credentials are configured
- Check IAM roles have proper permissions
- Ensure security groups allow inbound traffic on port 8080
- Check ECS task logs in CloudWatch

### CodePipeline Failures
- Verify GitHub token is valid
- Check buildspec.yml syntax
- Ensure ECR repository exists
- Review CodeBuild logs

---

## 📸 Screenshots

See [MOCKUPS.md](MOCKUPS.md) for detailed screenshots of:
- Jenkins Pipeline Execution
- Docker Container Running
- AWS ECR Repository
- AWS ECS Service
- AWS CodePipeline
- Application Running in Browser
- CloudFormation Stack

---

## 📞 Contact

**Developer:** ArulKumar  
**Email:** arulkumar@example.com  
**GitHub:** [@arulkumar](https://github.com/arulkumar)  
**Assignment:** DevOps Sharpened DAP Completion

---

## 📄 License

This project is created for educational purposes as part of the DevOps Sharpened DAP Completion Assignment.

---

## ✅ Assignment Checklist

- [x] Task 1: Created SpringBoot application in public GitHub repository
- [x] Task 2: Jenkins pipeline configured and working
- [x] Task 3: Application containerized and running on AWS ECS
- [x] Task 4: AWS CodePipeline configured with buildspec.yml
- [x] Task 5: CloudFormation template created for complete pipeline

**All tasks completed by: ArulKumar** ✅

---

## 🎉 Thank You!

This project demonstrates a complete DevOps CI/CD implementation with industry best practices.

**Created with ❤️ by ArulKumar**
