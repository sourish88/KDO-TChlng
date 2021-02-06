#Setup terraform
terraform {
    # Define minimum required version of terraform
    required_version = "~> 0.13.0"

    # Define minimum version required for AWS provider
    required_providers {
      aws = {
          version = "~> 3.27.0"
      }
    }
    # Setup backend as S3 for storing tfstate
    backend "s3" {
        bucket = "tf-dev-state-bucket-1"
        key = "global/s3/dev/terraform.tfstate"
        region = "eu-west-2"
        dynamodb_table = "tf-dev-state-lock"
        encrypt = true
    }
}

# Configure provider as AWS
provider "aws" {
  region = "eu-west-2" # London Region
}

# Create cloud network
# creating a new vpc with dns resolution support
module "network" {
  source = "terraform-aws-modules/vpc/aws"

  name = format("%s-vpc", var.name)
  azs = var.vpc_azs
  cidr = var.vpc_cidr

  public_subnets = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets
  database_subnets = var.vpc_database_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway
  one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az

  tags = {
    Name      = "${var.name}-vpc"
    BuildWith = "terraform"
    Environment = var.name
  } 
}

module "security" {
    source = "./modules/security"

    name = var.name
    vpc_id = module.network.vpc_id
    web_port = var.web_port
    app_port = var.app_port
    db_port = var.db_port
    private_subnets_cidr_blocks = module.network.private_subnets_cidr_blocks
    public_subnets_cidr_blocks = module.network.public_subnets_cidr_blocks
    database_subnets = module.network.database_subnets
}

module "compute" {
    source = "./modules/compute"

    name = var.name
    public_key = var.public_key
    web_port = var.web_port
    app_port = var.app_port
    web_sec_grp_id = module.security.web_sec_grp_id
    app_sec_grp_id = module.security.app_sec_grp_id
    rds_sec_grp_id = module.security.rds_sec_grp_id
    web_elb_sec_grp_id = module.security.web_elb_sec_grp_id
    app_elb_sec_grp_id = module.security.app_elb_sec_grp_id
    public_subnets = module.network.public_subnets
    private_subnets = module.network.private_subnets
    database_subnets = module.network.database_subnets
    db_username = var.db_username
    db_password = var.db_password
    db_port = var.db_port
}