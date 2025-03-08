resource "aws_ecr_repository" "webapp_repo" {
  name = var.webapp_repo_name
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "mysql_repo" {
  name = var.mysql_repo_name
  image_scanning_configuration {
    scan_on_push = true
  }
}


