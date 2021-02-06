resource "aws_security_group" "elb_app" {
  name = format("%s-elb-app-sg", var.name)

  vpc_id = var.vpc_id

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-app-elb-sg"
    BuildWith = "terraform"
    Environment = var.name
  }

}