resource "aws_ecr_repository" "ecr_api_repo" {
  name                 = "${var.project}-${var.region}-${var.env}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.common_tags
}
