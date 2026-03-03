# AWS Console Deployment Guide - Complete Setup
## Deploying Spring Boot Application with CI/CD Pipeline to AWS

**Repository:** https://github.com/arulkumarcn-dev/Devops-DAP
**Region:** us-east-1 (N. Virginia)

---

## STEP 1: Create GitHub Personal Access Token (PAT)

1. Go to: https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Configure the token:
   - **Note:** `AWS CodePipeline - Devops-DAP`
   - **Expiration:** 90 days
   - **Select scopes:**
     - ✅ **repo** (Full control of private repositories) - CHECK ALL sub-options
     - ✅ **admin:repo_hook** (Full control of repository hooks) - CHECK ALL sub-options
4. Click **"Generate token"**
5. **COPY THE TOKEN IMMEDIATELY** - Save it securely (you'll need it in Step 3)

---

## STEP 2: Prepare CloudFormation Template

The template file is ready at: **`d:\Build\aws-deployment-stack.yaml`**

This template creates:
- ✅ VPC with Public Subnets (2 AZs)
- ✅ Application Load Balancer (ALB)
- ✅ ECR Repository for Docker images
- ✅ ECS Fargate Cluster & Service
- ✅ CodePipeline with GitHub integration
- ✅ CodeBuild for building Docker images
- ✅ All necessary IAM roles and security groups
- ✅ CloudWatch Logs for application logs
- ✅ S3 bucket for pipeline artifacts

---

## STEP 3: Deploy via AWS CloudFormation Console

### A. Go to CloudFormation Console

1. Open AWS Console: https://console.aws.amazon.com/
2. **VERIFY YOU'RE IN US-EAST-1 REGION** (top right corner - should say "N. Virginia")
3. Search for **"CloudFormation"** in the top search bar
4. Click **CloudFormation** to open the service

### B. Create Stack

1. Click **"Create stack"** → **"With new resources (standard)"**

2. **Specify template:**
   - Select **"Upload a template file"**
   - Click **"Choose file"**
   - Navigate to: `d:\Build\aws-deployment-stack.yaml`
   - Click **"Next"**

### C. Configure Stack Details

1. **Stack name:** `arulkumar-devops-pipeline-stack`

2. **Parameters:**
   - **ApplicationName:** `arulkumar-devops-app` (leave default)
   - **GitHubUser:** `arulkumarcn-dev` (pre-filled)
   - **GitHubRepo:** `Devops-DAP` (pre-filled)
   - **GitHubBranch:** `main` (pre-filled)
   - **GitHubToken:** PASTE YOUR GITHUB TOKEN FROM STEP 1

3. Click **"Next"**

### D. Configure Stack Options

1. **Tags** (optional but recommended):
   - Key: `Project`, Value: `DevOps-DAP`
   - Key: `Environment`, Value: `Production`

2. **Permissions:** Leave as default (or select an existing IAM role if you have one)

3. **Stack failure options:** Select **"Roll back all stack resources"**

4. Click **"Next"**

### E. Review and Create

1. **Review all parameters carefully**

2. **Acknowledgments:**
   - ✅ Check "I acknowledge that AWS CloudFormation might create IAM resources with custom names"
   - ✅ Check "I acknowledge that AWS CloudFormation might require the following capability: CAPABILITY_NAMED_IAM"

3. Click **"Submit"** / **"Create stack"**

### F. Monitor Stack Creation

1. You'll see the **Events** tab showing stack creation progress
2. **Estimated time: 10-15 minutes**
3. Watch for these key resources:
   - VPC, Subnets, Internet Gateway
   - ECR Repository
   - ECS Cluster
   - Load Balancer
   - CodeBuild Project
   - CodePipeline

4. **Stack Status:** Should change from `CREATE_IN_PROGRESS` → `CREATE_COMPLETE`

---

## STEP 4: Verify Stack Creation

### Check Outputs Tab

Once stack is **CREATE_COMPLETE**, click the **"Outputs"** tab to see:

| Output Key | Description | Example Value |
|------------|-------------|---------------|
| **LoadBalancerURL** | Your application URL | `http://arulk-LoadB-xxx.us-east-1.elb.amazonaws.com` |
| **LoadBalancerHealthCheck** | Health endpoint | `http://.../api/health` |
| **LoadBalancerWelcome** | Welcome endpoint | `http://.../api/welcome` |
| **ECRRepositoryURI** | Docker registry | `123456789.dkr.ecr.us-east-1.amazonaws.com/arulkumar-devops-app` |
| **PipelineConsoleURL** | View pipeline | `https://console.aws.amazon.com/...` |
| **ECSClusterName** | Cluster name | `arulkumar-devops-app-cluster` |
| **ECSServiceName** | Service name | `arulkumar-devops-app-service` |

**SAVE THESE VALUES** - you'll need them!

---

## STEP 5: Trigger First Pipeline Run

### Option A: Via GitHub Push (Recommended)

1. Make any small change to your repository (e.g., update README.md)
2. Commit and push to the `main` branch
3. The webhook will automatically trigger the pipeline

### Option B: Manual Trigger via Console

1. Click the **PipelineConsoleURL** from Outputs tab
2. Click **"Release change"** button
3. Confirm the release

---

## STEP 6: Monitor Pipeline Execution

### View Pipeline Progress

1. Go to: AWS Console → **CodePipeline**
2. Click on **`arulkumar-devops-app-pipeline`**
3. You'll see 3 stages:

   **Stage 1: Source** (1-2 minutes)
   - Fetches code from GitHub
   - Status: ✅ Succeeded

   **Stage 2: Build** (5-8 minutes)
   - Builds Maven project
   - Creates Docker image
   - Pushes to ECR
   - Click **"Details"** to see build logs

   **Stage 3: Deploy** (2-3 minutes)
   - Updates ECS service with new image
   - Health checks pass
   - Status: ✅ Succeeded

### Total Pipeline Time: ~10-15 minutes

---

## STEP 7: Verify Application is Running

### Check ECS Service

1. Go to: AWS Console → **ECS** (Elastic Container Service)
2. Click **Clusters** → **`arulkumar-devops-app-cluster`**
3. Click **Services** tab → **`arulkumar-devops-app-service`**
4. Verify:
   - **Running count:** 1
   - **Desired count:** 1
   - **Status:** ACTIVE

### Check Running Tasks

1. Click **Tasks** tab
2. You should see 1 running task
3. Click the task ID
4. Verify **Last status:** RUNNING
5. Click **Logs** tab to see application logs

---

## STEP 8: Test Your Application

### Test Endpoints

Open your browser or use curl:

#### 1. Health Check Endpoint
```bash
curl http://YOUR-LOAD-BALANCER-URL/api/health
```
**Expected Response:**
```json
{
  "status": "UP",
  "timestamp": "2024-03-03T..."
}
```

#### 2. Welcome Endpoint
```bash
curl http://YOUR-LOAD-BALANCER-URL/api/welcome
```
**Expected Response:**
```json
{
  "message": "Welcome to DevOps Application!",
  "developer": "ArulKumar",
  "features": [...]
}
```

#### 3. Info Endpoint
```bash
curl http://YOUR-LOAD-BALANCER-URL/api/info
```

### Access via Browser

Simply paste your **LoadBalancerURL** in a browser:
```
http://arulk-LoadB-XXXXXXXXX.us-east-1.elb.amazonaws.com/api/welcome
```

---

## STEP 9: Monitor and Manage

### CloudWatch Logs

1. Go to: AWS Console → **CloudWatch**
2. Click **Log groups** → **`/ecs/arulkumar-devops-app`**
3. View application logs in real-time

### ECR Repository

1. Go to: AWS Console → **ECR** (Elastic Container Registry)
2. Click **`arulkumar-devops-app`**
3. See all pushed Docker images with tags

### Pipeline Monitoring

- **CodePipeline Console:** Monitor all pipeline executions
- **CodeBuild Console:** View detailed build logs
- **ECS Console:** Monitor service health and tasks

---

## STEP 10: Continuous Deployment (Automatic)

Now that everything is set up, **every push to the `main` branch** will:

1. ✅ Trigger GitHub webhook
2. ✅ Start CodePipeline automatically
3. ✅ Build new Docker image via CodeBuild
4. ✅ Push image to ECR
5. ✅ Deploy to ECS (rolling update, zero downtime)
6. ✅ Health checks ensure new version is healthy
7. ✅ Application is live with new changes

---

## Troubleshooting Guide

### Pipeline Failed at Build Stage

**Check CodeBuild logs:**
1. Go to CodePipeline → Click **"Details"** on Build stage
2. Check for errors:
   - Maven build errors → Fix code issues
   - Docker build errors → Check Dockerfile
   - ECR push errors → Check IAM permissions

### Pipeline Failed at Deploy Stage

**Check ECS Service:**
1. Go to ECS → Clusters → Your cluster
2. Click Services → Events tab
3. Common issues:
   - Health check failing → Check `/api/health` endpoint
   - Image pull errors → Verify ECR permissions
   - Task failed to start → Check CloudWatch logs

### Application Not Accessible

1. **Check Load Balancer:**
   - Go to EC2 → Load Balancers
   - Verify state is **Active**

2. **Check Target Group health:**
   - Go to EC2 → Target Groups
   - Click **`arulkumar-devops-app-tg`**
   - Verify targets show as **healthy**

3. **Check Security Groups:**
   - ALB Security Group: Port 80 open to 0.0.0.0/0
   - ECS Security Group: Port 8080 open from ALB SG

### GitHub Webhook Not Working

1. Go to GitHub repo → Settings → Webhooks
2. You should see an AWS webhook
3. Click on it → Check "Recent Deliveries"
4. Re-deliver if needed

---

## Cost Estimate (Free Tier Optimized)

**Monthly costs (after free tier):**
- **ECS Fargate:** ~$10-15/month (256 CPU, 512MB RAM)
- **ALB:** ~$16-20/month
- **ECR:** ~$0.10/GB/month (first 500MB free)
- **S3:** ~$0.10/month (artifacts)
- **CloudWatch Logs:** Minimal (<$1/month)
- **CodeBuild:** Free tier: 100 build minutes/month
- **VPC, NAT:** Free (using public subnets)

**Estimated Total:** ~$30-40/month

**To minimize costs:**
- Delete stack when not in use
- Use FARGATE_SPOT for ECS (already configured)
- Keep log retention at 7 days

---

## Cleanup Instructions (Delete Everything)

When you're done testing:

1. Go to: AWS Console → **CloudFormation**
2. Select **`arulkumar-devops-pipeline-stack`**
3. Click **"Delete"**
4. Confirm deletion

**Note:** Before deleting:
- Empty the S3 artifacts bucket manually if deletion fails
- Delete any ECR images if needed

The stack will delete all resources automatically:
- VPC and networking
- Load Balancer
- ECS Cluster and Service
- ECR Repository
- CodePipeline and CodeBuild
- IAM Roles
- CloudWatch Logs
- S3 Bucket

---

## Success Checklist

Once deployment is complete, you should have:

- ✅ CloudFormation stack: **CREATE_COMPLETE**
- ✅ CodePipeline: **All stages succeeded**
- ✅ ECS Service: **1 task running**
- ✅ Load Balancer: **Active and healthy**
- ✅ Application accessible at LoadBalancerURL
- ✅ `/api/health` returns HTTP 200
- ✅ `/api/welcome` returns JSON response
- ✅ CloudWatch logs showing application startup
- ✅ Automatic deployments working on git push

---

## Next Steps

1. **Add custom domain:** Configure Route53 for custom domain
2. **Add HTTPS:** Request ACM certificate and add to ALB
3. **Add database:** Use RDS and connect from ECS
4. **Add monitoring:** Set up CloudWatch alarms
5. **Add auto-scaling:** Configure ECS service auto-scaling

---

## Support & Documentation

- **CloudFormation Template:** `d:\Build\aws-deployment-stack.yaml`
- **BuildSpec:** `d:\Build\buildspec.yml`
- **GitHub Repo:** https://github.com/arulkumarcn-dev/Devops-DAP
- **AWS Free Tier:** https://aws.amazon.com/free/
- **AWS ECS Documentation:** https://docs.aws.amazon.com/ecs/
- **AWS CodePipeline:** https://docs.aws.amazon.com/codepipeline/

---

**Deployment Guide Version:** 1.0
**Last Updated:** March 3, 2026
**Author:** Claude Code Assistant
**For:** arulkumarcn-dev/Devops-DAP
