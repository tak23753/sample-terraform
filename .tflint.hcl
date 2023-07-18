config {
  module = true
}

plugin "aws" {
  enabled = true
  version = "0.24.1"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule  "terraform_required_providers" {
  enabled = false
}

rule  "terraform_required_version" {
  enabled = false
}
