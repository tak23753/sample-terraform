data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  # 関数ディレクトリ以下のファイルのハッシュ値
  function_file_hash = md5(join("", [
    for file in fileset(var.function_dir_path, "*")
    : filemd5("${var.function_dir_path}/${file}")
  ]))
}

# ---------------------------------------------------------
# ECR
# ---------------------------------------------------------

module "ecr" {
  source = "../ecr"

  prefix              = "${var.prefix}-lambda"
  force_delete        = true
  holding_image_count = 3
  kms_key_arn         = var.ecr_kms_key_arn
}

# イメージのデプロイ
resource "terraform_data" "lambda_build" {
  # ECRのリポジトリURLと、関数コードのハッシュをトリガーにする
  triggers_replace = [
    local.function_file_hash,
    module.ecr.repository_url,
  ]

  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${module.ecr.repository_url}"
  }

  provisioner "local-exec" {
    working_dir = var.function_dir_path
    command     = "docker build --platform linux/arm64 -t ${var.prefix}-image ."
  }

  provisioner "local-exec" {
    command = "docker tag ${var.prefix}-image:latest ${module.ecr.repository_url}:${local.function_file_hash}"
  }

  provisioner "local-exec" {
    command = "docker push ${module.ecr.repository_url}:${local.function_file_hash}"
  }
}

# ---------------------------------------------------------
# IAM
# ---------------------------------------------------------

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "lambda_basic_execution" {
  name = "AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "lambda" {
  name               = "${var.prefix}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json

  tags = {
    Name = "${var.prefix}-lambda-role"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.lambda.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution.arn
}

# ---------------------------------------------------------
# Lambda
# ---------------------------------------------------------

resource "aws_lambda_function" "this" {
  function_name = "${var.prefix}-lambda-function"
  architectures = ["arm64"]
  image_uri     = "${module.ecr.repository_url}:${local.function_file_hash}"
  role          = aws_iam_role.lambda.arn
  package_type  = "Image"
  timeout       = var.timeout

  tracing_config {
    mode = "Active"
  }

  depends_on = [
    terraform_data.lambda_build,
  ]
}
