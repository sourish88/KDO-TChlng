resource "aws_security_group" "rds" {
  name = format("%s-rds-sg", var.name)

  vpc_id = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr_blocks
  }

  tags = {
    Name = "${var.name}-rds-sg"
    BuildWith = "terraform"
    Environment = var.name
  }

}