# DevOps
# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction


This is my first project for the Udacity Nanodegree "Cloud DevOps using Microsoft Azure" .

The task is to deploy a web application to Azure. The application is self-contained, but the infrastructure to deploy is need in a customizable way.
It should be deployed as an Iaas and across multiple virtual machines.

Therefor I created a server image with Packer and used Terraform to create a template for deploying a scalable cluster of servers with a load balancer to manage the incoming traffic.
Further I added a policy to deny any deployments of resources without a tag.

### Requirements:
- Create an Azure Account
- Install Packer
- Install Terraform

### How to use 
#### 1. Change the credentials to your own Azure credentials

#### 2. Create an Azure Subscription and a resource group

#### 3. Deploy the policy to your resoure group

#### 4. Deploy the packer image:

$ packer build packer/server.json

#### 5. Preparation and creation of the Terraform template for the ressources to deploy

##### 5a.Modify variables for your own purpose:
The file terraform/vars.tf includes all varialbes used inside the terraform/main.tf terraform template. If you want to use your own code, you need to modify the variables in terraform/vars.tf first. For example to use other name conventions for your infrastructure, other azure region etc.

##### 5b. Creation of Terraform template
'- $ terraform init
'- $ terraform plan -out solution.plan

#### 6. Deploy with Terraform by use of the packer image

$ terraform apply "solution1.plan"

#### 7. Destroy resources if not required anymore ( be careful of costs!):
$ terraform destroy
