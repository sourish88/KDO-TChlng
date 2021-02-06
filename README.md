# DevOps Tech Challenge

This repository contains solutions to provided challenges. Solutions for each challenge is described below.

## Challenege 1
### Problem Statement
A 3 tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility.
### Solution
The requirement is to setup 3 tier environment which can be easily reproduced multiple times. For example, building Dev and Test environments which should be aligned to each other w.r.t infrastructure for proving better test results. Terraform is widely used standard tool for documenting Infrastructure as Code. Terraform will solve the probelem of creating a reproducible environment as well as version controlling each change being made in the infrastructure.

So, here I have used AWS as a cloud platform where I am creating 3 tier infrastruture and running an application on it. 3 tier envirments 3 main components suc has web sever, application server and database. As a standard practice, this kind of environments are built on 3 types of subnets based on the restrictions which are as mentioned below:

1. Public Subnet - This will be the public subnet which is facing the end user and is open to internet through internet gate. This subnet is less secure since it is internet facing vulnerable to attacks. Hence, this is being used only to deploy the web server

2. Private Subnet - Private is is more secured subnet which will not be facing the internet. Which means it will use NAT Gateway to only send request to internet. This is restricts all the traffic coming directly from internet. Hence, will be used to application server which will only recieve traffic only via public subnet above using secured internal private network of AWS Cloud.

3. Restrcited/Database subnet - This subnet is the most secured subnet without any NAT gateway as well as Internet Gateway. We will use this subnet to deploy database which will hold the critical user data.

The high level architecture is shown below:
![3 Tier Architecture](Images/3-tier-arch.png)

Here are the steps to deploy aboe architecture using terraform on AWS Cloud.

<b><u>Pre-requisites</u></b>
1. Create openSSH Key in your home directory (~/.ssh/id_rsa) using following command

`ssh-keygen -t rsa -b 4096 -C "Enter you comment"`

2. Install AWS CLI and setup your AWS access key and secret key

`aws config`

3. Create S3 bucket for storing tfstate file. Name it as 'tf-dev-state-bucket-1'.

4. Install terraform CLI.

5. Create DynomoDB table called 'tf-dev-state-lock' with the key called 'LockID'.

<b><u>Apply terraform:</u></b>

Step-1: Clone this git repository
`git clone https://github.com/sourish88/KDO-TChlng.git`

Step-2: Run below command to to initialise terraform

`cd Challenge-1`

`terraform init`

Step-3: Run below command to generate terraform plan for the changes

`terraform plan -var-file="env/dev.tfvars" --var db_username=<ENTER USERNAME> --var db_password=<ENTER PASSWORD> -out tfplan.out`

Step-4: Validate your changes in the generated TF Plan

`terraform show tfplan.out`

Step-5: Once you are happy with the changes shown in TF plan, run below to apply and approve when asked

`terraform apply -var-file="env/dev.tfvars" --var db_username=<ENTER USERNAME> --var db_password=<ENTER PASSWORD> tfplan.out`

<b><u>Test Application</b></u>
It is a simple Angular Application which stores the Customer entry in RDS database and shows list of customers currently added in database. Login to AWS console and find the DNS Name of 'dev-elb-web' loadbalancer. Paste the DNS name in the browser which will present you this page:
![Sample Web App](Images/Angular-App.png)

Try and add your firstname and last name. Then click on 'Customers' button and check if you can see your name listed. Also, try and search your last name to get your full name.