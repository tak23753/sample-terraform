# ---------------------------------------------------------
# Repository
# ---------------------------------------------------------

resource "aws_ecr_repository" "this" {
  name                 = "${var.prefix}-ecr"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = var.force_delete

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = var.kms_key_arn
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.prefix}-ecr"
  }
}

# ---------------------------------------------------------
# Lifecycle Policy
# ---------------------------------------------------------

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy = jsonencode(
    {
      "rules" : [
        {
          "rulePriority" : 1,
          "description" : "Hold only ${var.holding_image_count} images, expire all others",
          "selection" : {
            "tagStatus" : "any",
            "countType" : "imageCountMoreThan",
            "countNumber" : var.holding_image_count
          },
          "action" : {
            "type" : "expire"
          }
        }
      ]
    }
  )
}
