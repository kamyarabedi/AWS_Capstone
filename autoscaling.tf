# Adding Auto Scaling

# Launch Template
resource "aws_launch_template" "launch-template" {
  name                   = "kamyar-wordpress-template"
  image_id               = data.aws_ami.amazon_linux_2.id
  instance_type          = var.aws_instance_type_t2micro
  vpc_security_group_ids = [aws_security_group.aws_webserver_sg.id, aws_security_group.aws_private_ssh_sg.id]
  user_data              = base64encode(templatefile("userdata.sh", { rds_endpoint = replace(aws_db_instance.mysql.endpoint, ":3306", ""), efs_id = aws_efs_file_system.wordpress.id, aws_region = var.region_us_east_1, db_password = var.db_password }))
  key_name               = var.key_pair_name
}

# Auto Scaling Group
resource "aws_autoscaling_group" "autoscaling-group" {
  depends_on       = [aws_nat_gateway.nat, aws_efs_mount_target.private_a, aws_efs_mount_target.private_b]
  default_cooldown = 30
  launch_template {
    id      = aws_launch_template.launch-template.id
    version = "$Latest"
  }
  desired_capacity = 2 # 1 for testing
  min_size         = 2 # 1 for testing
  max_size         = 3 # 2 for testing

  target_group_arns   = [aws_lb_target_group.capstone_tg.arn]
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  tag {
    key                 = "Name"
    value               = "kamyar-AutoScale-Wordpress"
    propagate_at_launch = true
  }
}

# Scaling Policy
resource "aws_autoscaling_policy" "scale-out-policy" {
  name                      = "scale-out-policy"
  autoscaling_group_name    = aws_autoscaling_group.autoscaling-group.name
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 30
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0 # 20 for testing
  }
}

# Target group is attached through target_group_arns above.
