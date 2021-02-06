module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.name}-rds"

  engine            = "postgres"
  engine_version    = "9.6.3"
  major_engine_version = "9.6"
  instance_class    = "db.t2.micro"
  allocated_storage = var.db_allocated_storage

  name = "${var.name}db"
  username = var.db_username
  password = var.db_password
  port     = var.db_port

  vpc_security_group_ids = [var.rds_sec_grp_id]

  maintenance_window = var.db_maintenance_window
  backup_window      = var.db_backup_window

  # disable backups to create DB faster
  backup_retention_period = var.db_backup_retention_period

  subnet_ids = var.database_subnets

  family = "postgres9.6"

  tags = {
    Name = "${var.name}-rds"
    BuildWith = "terraform"
    Environment = var.name
  }

}