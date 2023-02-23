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

#### 5. Create the Terraform template for the ressources to deploy

Main.tf and vars.tf contain all resources to create and the variables. If other resources are required, it can be modified.

$ terraform init
$ terraform plan -out solution.plan

#### 6. Deploy with Terraform by use of the packer image

$ terraform apply "solution.plan"

#### 7. Destroy resources if not required anymore ( be careful of costs!):
