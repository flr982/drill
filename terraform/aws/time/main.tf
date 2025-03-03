provider "aws" {
  region = var.region
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.env
    CreatedBy   = "Terraform"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "drill-tf-states"
    key    = "vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_launch_template" "time" {
  name_prefix            = "time-asg-"
  image_id               = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  user_data              = base64encode(file("user-data.sh")) # Base64 encoding required for launch templates
  vpc_security_group_ids = [aws_security_group.time_asg.id]

  #   network_interfaces {
  #     security_groups = [aws_security_group.time_asg.id]
  #   }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "time" {
  name                = "time"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnet_ids


  launch_template {
    id      = aws_launch_template.time.id
    version = "$Latest" # Always use the latest version
  }

  health_check_type = "ELB"

  lifecycle {
    ignore_changes = [desired_capacity, target_group_arns]
  }

  # Dynamic block to merge local.common_tags and custom tags
  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  # Explicit "Name" tag
  tag {
    key                 = "Name"
    value               = "${var.project}-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "time" {
  name               = "time-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.time_lb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  tags               = local.common_tags
}

resource "aws_lb_target_group" "time" {
  name     = "time-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = local.common_tags
}

resource "aws_lb_listener" "time" {
  load_balancer_arn = aws_lb.time.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.time.arn
  }

  tags = local.common_tags
}

resource "aws_autoscaling_attachment" "time" {
  autoscaling_group_name = aws_autoscaling_group.time.id
  lb_target_group_arn    = aws_lb_target_group.time.arn
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "time_scale_down"
  autoscaling_group_name = aws_autoscaling_group.time.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 120
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = "Monitors CPU utilization for Time ASG"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "time_scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "10"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.time.name
  }
}



terraform {
  backend "s3" {
    bucket  = "drill-tf-states"
    key     = "time/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
