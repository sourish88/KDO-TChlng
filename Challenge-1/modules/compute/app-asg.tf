data "template_file" "app_user_data" {
    template = file("${path.module}/templates/app-user-data.tpl")

    vars = {
      this_db_instance_address = module.rds.this_db_instance_address
      db_port = var.db_port
      db_name = "${var.name}-db"
      db_username = var.db_username
      db_password = var.db_password
      app_port = var.app_port
    }
}

resource "aws_launch_configuration" "app" {
  image_id        = data.aws_ami.amazon_linux.id
  instance_type   = var.app_instance_type
  security_groups = [var.app_sec_grp_id]
  #TODO REMOVE
  key_name = "ssh-key"
  name_prefix = "${var.name}-app-vm-"

  user_data = base64encode(data.template_file.app_user_data.rendered)

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "app" {
  launch_configuration = aws_launch_configuration.app.id

  vpc_zone_identifier = var.private_subnets

  load_balancers    = [module.elb_app.this_elb_name]
  health_check_type = "EC2"

  min_size = var.app_autoscale_min_size
  max_size = var.app_autoscale_max_size

  tags = concat (
    [
        {
            key = "Name" 
            value = "${var.name}-app-server"
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
 depends_on = [ module.rds ]
}