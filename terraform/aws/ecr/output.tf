output "ecr_name" {
  value       = module.ecr.ecr_name
  description = "The repo name"
}

output "ecr_url" {
  value       = module.ecr.ecr_url
  description = "The ecr repo url"
}
