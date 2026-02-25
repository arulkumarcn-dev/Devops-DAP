# AWS CLI Commands for ArulKumar DevOps Assignment

# Set your AWS Account ID and Region
$AWS_ACCOUNT_ID="<YOUR_AWS_ACCOUNT_ID>"
$AWS_REGION="<YOUR_AWS_REGION>"
$APP_NAME="arulkumar-devops-app"

# 1. Create ECR Repository
aws ecr create-repository `
    --repository-name $APP_NAME `
    --region $AWS_REGION `
    --tags Key=Developer,Value=ArulKumar

# 2. Login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

# 3. Build and Push Docker Image
docker build -t $APP_NAME .
docker tag "${APP_NAME}:latest" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${APP_NAME}:latest"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${APP_NAME}:latest"

# 4. Create ECS Cluster
aws ecs create-cluster `
    --cluster-name "${APP_NAME}-cluster" `
    --region $AWS_REGION `
    --tags Key=Developer,Value=ArulKumar

# 5. Register Task Definition
aws ecs register-task-definition `
    --cli-input-json file://ecs-task-definition.json `
    --region $AWS_REGION

# 6. Create ECS Service
aws ecs create-service `
    --cluster "${APP_NAME}-cluster" `
    --service-name "${APP_NAME}-service" `
    --task-definition $APP_NAME `
    --desired-count 1 `
    --launch-type FARGATE `
    --network-configuration "awsvpcConfiguration={subnets=[subnet-xxxxx],securityGroups=[sg-xxxxx],assignPublicIp=ENABLED}" `
    --region $AWS_REGION `
    --tags Key=Developer,Value=ArulKumar

# 7. Deploy CloudFormation Stack
aws cloudformation create-stack `
    --stack-name arulkumar-devops-stack `
    --template-body file://cloudformation-pipeline.yaml `
    --parameters ParameterKey=GitHubToken,ParameterValue=<YOUR_GITHUB_TOKEN> `
                 ParameterKey=GitHubUser,ParameterValue=arulkumar `
                 ParameterKey=GitHubRepo,ParameterValue=devops-assignment `
    --capabilities CAPABILITY_NAMED_IAM `
    --region $AWS_REGION `
    --tags Key=Developer,Value=ArulKumar

# 8. Check Stack Status
aws cloudformation describe-stacks `
    --stack-name arulkumar-devops-stack `
    --region $AWS_REGION `
    --query 'Stacks[0].StackStatus'

# 9. Get Load Balancer URL
aws cloudformation describe-stacks `
    --stack-name arulkumar-devops-stack `
    --region $AWS_REGION `
    --query 'Stacks[0].Outputs[?OutputKey==`LoadBalancerURL`].OutputValue' `
    --output text

# 10. List Running Tasks
aws ecs list-tasks `
    --cluster "${APP_NAME}-cluster" `
    --service-name "${APP_NAME}-service" `
    --region $AWS_REGION
