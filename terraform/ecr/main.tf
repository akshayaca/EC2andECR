resource "aws_ecr_repository" "webapp_repo" {
  name                 = "webapp-repo"
  image_tag_mutability = "MUTABLE"

  tags = {
    Environment = "Production"
  }
}

resource "aws_ecr_repository" "mysql_repo" {
  name                 = "mysql-repo"
  image_tag_mutability = "MUTABLE"

  tags = {
    Environment = "Production"
  }
}
