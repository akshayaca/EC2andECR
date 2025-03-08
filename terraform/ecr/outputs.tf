output "webapp_repo_url" {
  value = aws_ecr_repository.webapp_repo.repository_url
}

output "mysql_repo_url" {
  value = aws_ecr_repository.mysql_repo.repository_url
}
