output "public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "The public IP of the bastion"
}

output "id" {
  value       = aws_instance.bastion.id
  description = "The ID of the bastion"
}
