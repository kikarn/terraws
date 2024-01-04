# Terraws

Do cool stuff with Terraform and AWS..

Just trying to learn something new...


## What does it do?

The code sets up x number of EC2 instances and installs nginx. It also creates a load balancer and a S3 bucket to which html+images is uploaded. Furthermore, some network stuff like VPC, subnets, routes.. 

Everything should fall under Free Tier in AWS and don't cost anything. Let's hope that's true. 

## The files

* instances.tf - Config for the EC2 instance
* loadbalance.tf	- Config for the ELB
* locals.tf - Local values for naming prefixes etc. 
* main.tf - Not much, just the providers in use
* network.tf - Config for network settings
* outputs.tf - Output that is returned, for now just the DNS record towards the loadbalancer
* s3.tf - S3 bucket config
* security.tf - IAM roles and securuty groups
* variables.tf - Variables that is used among the files are stored here

## How to do?

Google the pre-reqs, like install Terraform and awscli. 
Create a account on AWS. Then, create an IAM user and generate a key pair to use. 

Then, in "Terraform folder":
terraform init
terrafrom validate
terraform apply
.
.
.
Wait for the finish, navigate to the URL returned. 
