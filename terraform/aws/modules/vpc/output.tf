output "vpc_id" {
  value = aws_vpc.Main.id
}


output "public_subnet_ids" {
  value = values(aws_subnet.public_subnet).*.id
}

output "private_subnet_ids" {
  value = try([for subnet in aws_subnet.private_subnet : subnet.id], [])
}
