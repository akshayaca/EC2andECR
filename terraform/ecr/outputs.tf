output "webapp_repo_url" {
  value       = aws_ecr_repository.webapp_repo.repository_url
  description = "Web application ECR repository URL"
}

output "mysql_repo_url" {
  value       = aws_ecr_repository.mysql_repo.repository_url
  description = "MySQL ECR repository URL"
}
