resource "aws_key_pair" "ssh-key" {
  key_name = "ssh-key"
  public_key = file(var.public_key)

}

data "template_file" "web_user_data" {
    template = file("${path.module}/templates/web-user-data.tpl")

    vars = {
      this_elb_dns_name = module.elb_app.this_elb_dns_name
      app_port = var.app_port
      web_port = var.web_port
    }
}

resource "aws_launch_configuration" "web" {
  image_id        = data.aws_ami.amazon_linux.id
  instance_type   = var.web_instance_type
  security_groups = [var.web_sec_grp_id]
  key_name = "ssh-key"
  name_prefix = "${var.name}-web-vm-"

  user_data = base64encode(data.template_file.web_user_data.rendered)

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "web" {
  launch_configuration = aws_launch_configuration.web.id

  vpc_zone_identifier = var.public_subnets

  load_balancers    = [module.elb_web.this_elb_name]
  health_check_type = "EC2"

  min_size = var.web_autoscale_min_size
  max_size = var.web_autoscale_max_size

  tags = concat (
    [
        {
            key = "Name" 
            value = "${var.name}-web-server"
            propagate_at_launch = true
        },
        {
            key = "Buildwith" 
            value = "terraform"
            propagate_at_launch = true
        },
        {
            key = "Environment" 
            value = var.name
            propagate_at_launch = true
        }  
    ])
  depends_on = [ aws_autoscaling_group.app ]
}