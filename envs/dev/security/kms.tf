# ---------------------------------------------------------
# Log
# ---------------------------------------------------------

data "aws_iam_policy_document" "log_key" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
    principals {
      type        = "Service"
      identifiers = ["logs.${var.region}.amazonaws.com"]
    }
    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${var.region}:${var.account_id}:log-group:*"]
    }
  }
}

resource "aws_kms_key" "log" {
  description             = "${local.prefix}-log-key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.log_key.json

  tags = {
    Name = "${local.prefix}-log-key"
  }
}

resource "aws_kms_alias" "log" {
  name          = "alias/log"
  target_key_id = aws_kms_key.log.key_id
}

# ---------------------------------------------------------
# ECR
# ---------------------------------------------------------

resource "aws_kms_key" "ecr" {
  description             = "ECR"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Name = "${local.prefix}-ecr-key"
  }
}

resource "aws_kms_alias" "ecr" {
  name          = "alias/ecr"
  target_key_id = aws_kms_key.ecr.key_id
}
