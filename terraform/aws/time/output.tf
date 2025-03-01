output "lb_endpoint" {
  value = "http://${aws_lb.time.dns_name}"
}

output "asg_name" {
  value = aws_autoscaling_group.time.name
}
