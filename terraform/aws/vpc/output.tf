output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subtnet_ids" {
  value = module.vpc.public_subtnet_ids
}
