# Define mandatory parameterized variables

variable "region" {
  description = "The AWS region to deploy to"
  default = "eu-west-2"
}

variable "name" {
  description = "The name of the deployment"
  default = ""
}

variable "public_key" {
  default = ""
}

variable "web_port" {
  description = "The port on which the web servers listen for connections"
  default = 80
}

variable "app_port" {
  description = "The port on which the web servers listen for connections"
  default = 8080
}

# Borrowed from VPC Module from Terraform Module Repository:
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  default     = []
}

variable "vpc_database_subnets" {
  description = "A list of database subnets"
  default     = []
}

variable "vpc_azs" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "vpc_enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = false
}

variable "vpc_single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "vpc_one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  default     = false
}

# RDS
variable "db_username" {
  description = "Database user name"
}

variable "db_password" {
  description = "Database password"
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  default = 5432
}
