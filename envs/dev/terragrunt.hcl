remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket               = "${get_env("SYSTEM")}-${get_env("ENVIRONMENT")}-terraform-state-${get_env("AWS_ACCOUNT_ID")}-s3-bucket"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    region               = get_env("AWS_REGION")
    encrypt              = true
    bucket_sse_algorithm = "AES256"
    dynamodb_table       = "${get_env("SYSTEM")}-${get_env("ENVIRONMENT")}-terraform-lock-dynamodb-table"
    s3_bucket_tags = {
      "Terraform"   = "true"
      "Environment" = get_env("ENVIRONMENT")
      "System"      = get_env("SYSTEM")
    }
    dynamodb_table_tags = {
      "Terraform"   = "true"
      "Environment" = get_env("ENVIRONMENT")
      "System"      = get_env("SYSTEM")
    }
  }
}

inputs = {
  environment = get_env("ENVIRONMENT")
  system      = get_env("SYSTEM")
  account_id  = get_env("AWS_ACCOUNT_ID")
  region      = get_env("AWS_REGION")
}

generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("../../shared/provider.tf")
}

generate "version" {
  path      = "_version.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("../../shared/version.tf")
}

generate "variables" {
  path      = "_variables.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("../../shared/variables.tf")
}
