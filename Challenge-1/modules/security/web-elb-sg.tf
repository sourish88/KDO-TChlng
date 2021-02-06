resource "aws_security_group" "elb_web" {
  name = format("%s-elb-web-sg", var.name)

  vpc_id = var.vpc_id

  ingress {
    from_port   = var.web_port
    to_port     = var.web_port
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
    Name = "${var.name}-web-elb-sg"
    BuildWith = "terraform"
    Environment = var.name
  }
}