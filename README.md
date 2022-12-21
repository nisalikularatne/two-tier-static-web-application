# ACS_Group_15_FinalProject
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Build Status](https://github.com/terraform-linters/tflint/workflows/build/badge.svg?branch=master)](https://github.com/terraform-linters/tflint/actions)

The repository demonstrates a two-tier static web application hosting and configuration solution designed and implemented by group 15 of NAA batch.

## Objective of this project
The goal of this project is to create a two-tier static web application hosting and configuration solution utilizing source control, deployment automation and configuration management technologies.
The project also assesses technical proficiency in Terraform, Load Balancers, Auto Scaling Groups in scalable cloud architecture, AWS identity and access management and the efficient use of git source control along with Github Actions to automate security scanning.

## Tools and technologies learnt from working on this project
1. Terraform
2. Terragrunt
3. Github Actions
4. Github pre commits
5. Load Balancers
6. Auto Scaling Group
7. Scaling Policies

# Pre-commit hooks

This repo defines Git pre-commit hooks intended for use with [pre-commit](http://pre-commit.com/). The currently
supported hooks are:

* **terraform-fmt**: Automatically run `terraform fmt` on all Terraform code (`*.tf` files).
* **terraform-validate**: Automatically run `terraform validate` on all Terraform code (`*.tf` files).
* **detect-aws-credentials**: Detects if any keys are present in the repository


## Pre - Requisites
### Step - 1 (Github Repository Clone)
Clone the repository to your local environment of Cloud9 

```git clone git@github.com:nisalikularatne/ACS_Group_15_FinalProject.git```

### Step - 2 (Create 3 keys for each environment)
Go into the ~/.ssh folder of your environment and generate a key for each environment as shown below
```
ssh-keygen -t rsa -f Group15-dev
ssh-keygen -t rsa -f Group15-staging
ssh-keygen -t rsa -f Group15-prod
```
### Step - 3 (S3 Settings)
In the AWS portal under the S3 service create 3 buckets with the naming as shown below:

dev-acs730-finalproject-group15-bucket

staging-acs730-finalproject-group15-bucket

prod-acs730-finalproject-group15-bucket

The images in s3 bucket will be added using the terraform code. There is an images folder under
launchTemplate inside the project which will be copied into the S3 bucket on terraform apply command.

#### Note
In case you are unable to create a bucket if the name of the bucket
exists in S3, an update to the bucket name in config.tf must be done 
inside the project along with the variable "bucket_name" default should be
changed in each environment.
In the case of image updation, the image names must be changed in the 
install_httpd.sh.tpl

## Deployment and Destruction of Infrastructure
We have created the following modules
1. network
2. securityGroup
3. launchTemplate
4. targetGroup
5. applicationLoadBalancer
6. autoScalingGroup
7. scalingPolicies
8. bastionHost

In order to deploy the infrastructure, deploy the above mentioned resources in the same order in 3 environments as mentioned below
The Project folder will be using the files for each environment (dev, staging, prod)
### Dev
Inside of the ACS_Group_15_FinalProject
```
cd Project/dev
alias tf=terraform
tf init
tf fmt
tf validate
tf plan 
tf apply
```
### Staging
Inside of the ACS_Group_15_FinalProject
```
cd Project/staging
alias tf=terraform
tf init
tf plan 
tf apply
```
### Prod
Inside of the ACS_Group_15_FinalProject
```
cd Project/staging
alias tf=terraform
tf init
tf plan 
tf apply
```
In order to make the deployment faster we have integrated terragrunt.hcl files
which will rapidly deploy the infrastructure in all 3 environments using the commands below.
Run this command in the root of the project in CLI. This applies to all resources in dev, staging and prod
```terraform
 terragrunt run-all init
 terragrunt run-all apply
```
In order to destroy the resources reverse the order of the resources mentioned above
and follow the following command. Do it for all the resouces under
Project (dev, staging and prod)
```terraform
tf destroy
```
For destroying using terragrunt do the below:
```terraform
terragrunt run-all destroy
```
