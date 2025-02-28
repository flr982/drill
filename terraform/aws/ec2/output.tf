output "public_ip" {
  value       = module.ec2.public_ip
  description = "The public IP of the EC2 instance"
}

output "ids" {
  value       = module.ec2.id
  description = "The IDs of the EC2 instances"
}
