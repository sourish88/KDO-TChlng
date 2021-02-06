module "elb_web" {
  source = "terraform-aws-modules/elb/aws"

  name = format("%s-elb-web", var.name)

  subnets         = var.public_subnets
  security_groups = [var.web_elb_sec_grp_id]
  internal        = false

  listener = [
    {
      instance_port     = var.web_port
      instance_protocol = "HTTP"
      lb_port           = var.web_port
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
          target              = "HTTP:${var.web_port}/"
          interval            = var.web_elb_health_check_interval
          healthy_threshold   = var.web_elb_healthy_threshold
          unhealthy_threshold = var.web_elb_unhealthy_threshold
          timeout             = var.web_elb_health_check_timeout
      }

  tags = {  
    Name = "${var.name}-web-elb"
    BuildWith = "terraform"
    Environment = var.name
  }

  depends_on = [ aws_autoscaling_group.app ]

}