module "elb_app" {
  source = "terraform-aws-modules/elb/aws"

  name = format("%s-elb-app", var.name)

  subnets         = var.private_subnets
  security_groups = [var.app_elb_sec_grp_id]
  internal        = true

  listener = [
    {
      instance_port     = var.app_port
      instance_protocol = "TCP"
      lb_port           = var.app_port
      lb_protocol       = "TCP"
    },
  ]

  health_check = {
      target              = "TCP:${var.app_port}"
      interval            = var.app_elb_health_check_interval
      healthy_threshold   = var.app_elb_healthy_threshold
      unhealthy_threshold = var.app_elb_unhealthy_threshold
      timeout             = var.app_elb_health_check_timeout
    }

  tags = {
    Name = "${var.name}-app-elb"
    BuildWith = "terraform"
    Environment = var.name
  }

  depends_on = [ module.rds ]

}