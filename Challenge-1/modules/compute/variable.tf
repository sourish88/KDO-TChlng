data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name = "virtualization-type"

    values = ["hvm"]
  }

  owners = ["137112412989"]
}

variable "name" {
    description = "Environment name"
}

variable "public_key" {
  default = ""
}

# Web ASG
variable "web_instance_type" {
  description = "The EC2 instance type for the web servers"
  default = "t2.micro"
}

variable "web_autoscale_min_size" {
  description = "The fewest amount of EC2 instances to start"
  default = 2
}

variable "web_autoscale_max_size" {
  description = "The largest amount of EC2 instances to start"
  default = 3
}

variable "web_sec_grp_id" {
  description = "Web security group ID"
}

variable "app_sec_grp_id" {
  description = "App security group ID"
}

variable "rds_sec_grp_id" {
  description = "RDS security group ID"
}

variable "web_elb_sec_grp_id" {
  description = "Web ELB security group ID."
}

variable "app_elb_sec_grp_id" {
  description = "App ELB security group ID."
}

variable "public_subnets" {
  description = "Public subnets for web."
}

variable "private_subnets" {
  description = "Private subnets for app."
}

# Web ELB
variable "web_port" {
  description = "The port on which the web servers listen for connections"
  default = 80
}

variable "web_elb_health_check_interval" {
  description = "Duration between health checks"
  default = 20
}

variable "web_elb_healthy_threshold" {
  description = "Number of checks before an instance is declared healthy"
  default = 2
}

variable "web_elb_unhealthy_threshold" {
  description = "Number of checks before an instance is declared unhealthy"
  default = 2
}

variable "web_elb_health_check_timeout" {
  description = "Interval between checks"
  default = 5
}

# App ASG
variable "app_port" {
  description = "The port on which the application listens for connections"
  default = 8080
}

variable "app_instance_type" {
  description = "The EC2 instance type for the application servers"
  default = "t2.micro"
}

variable "app_autoscale_min_size" {
  description = "The fewest amount of EC2 instances to start"
  default = 2
}

variable "app_autoscale_max_size" {
  description = "The largest amount of EC2 instances to start"
  default = 3
}

# App ELB
variable "app_elb_health_check_interval" {
  description = "Duration between health checks"
  default = 20
}

variable "app_elb_healthy_threshold" {
  description = "Number of checks before an instance is declared healthy"
  default = 2
}

variable "app_elb_unhealthy_threshold" {
  description = "Number of checks before an instance is declared unhealthy"
  default = 2
}

variable "app_elb_health_check_timeout" {
  description = "Interval between checks"
  default = 5
}

# RDS

variable "database_subnets" {
  description = "CIDR Block for database subnets"
}
variable "db_allocated_storage" {
  description = "The allocated storage in GB"
  default = 5
}

variable "db_username" {
  description = "Username for the master DB user"
  default = ""
}

variable "db_password" {
  description = "Password for the master DB user"
  default = ""
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  default = 5432
}

variable "db_maintenance_window" {
  description = "The window to perform maintenance in"
  default = "Mon:00:00-Mon:03:00"
}

variable "db_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled"
  default = "03:00-06:00"
}

variable "db_backup_retention_period" {
  description = "The days to retain backups for"
  default = 0
}