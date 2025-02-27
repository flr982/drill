output "vpc_id" {
  value = aws_vpc.Main.id
}

# output "public_subtnet_ids" {
#   value = aws_subnet.public_subnet[each.key].id
# }


# output "public_subtnet_ids" {
#   value = toset([
#     for bd in aws_subnet.public_subnet : public_subnet.id
#   ])
# }

output "public_subtnet_ids" {
  value = values(aws_subnet.public_subnet).*.id
}
