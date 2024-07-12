AWS Infrastructure Deployment and Management with Terraform
This repository is dedicated to deploying and managing AWS infrastructure using Terraform.

Deploying Locally
To deploy locally, follow these steps:

1. Login to Terraform
First, you need to log in to Terraform via the console. For that, run:
terraform login

2. Initialize the Project
Then, you need to run:
npm run init

3. Build Your Resources:
Terraform will generate a plan in the tfplan file. To see what will be changed, you can visit Terraform Cloud or run the following command to see the changes locally:
TF_WORKSPACE=$stage terraform show -json tfplan > changes.json

4. Deploy Your Changes:
To deploy your changes, run:
npm run deploy
