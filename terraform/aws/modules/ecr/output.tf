output "ecr_name" {
  value       = aws_ecr_repository.ecr_api_repo.name
  description = "The repo name"
}

output "ecr_url" {
  value       = aws_ecr_repository.ecr_api_repo.repository_url
  description = "The ecr repo url"
}