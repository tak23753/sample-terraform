module "helloworld_lambda" {
  source = "../../../modules/lambda"

  prefix            = "${local.prefix}-helloworld"
  function_dir_path = "${path.module}/functions/helloworld"
  log_kms_key_arn   = var.log_kms_key_arn
  ecr_kms_key_arn   = var.ecr_kms_key_arn
}
