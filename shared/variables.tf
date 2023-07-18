# tflint-ignore: terraform_unused_declarations
variable "environment" {
  description = "環境のプレフィックス"
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "system" {
  description = "システム名称(-区切り)"
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "account_id" {
  description = "AWSアカウントID"
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "region" {
  description = "AWSリージョン"
  type        = string
}

locals {
  # tflint-ignore: terraform_unused_declarations
  prefix = "${var.system}-${var.environment}"
  # tflint-ignore: terraform_unused_declarations
  tags = {
    "Terraform"   = "true"
    "Environment" = var.environment
    "System"      = var.system
  }
}
