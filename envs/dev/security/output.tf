output "log_kms_key_arn" {
  value = aws_kms_alias.log.target_key_arn
}

output "ecr_kms_key_arn" {
  value = aws_kms_alias.ecr.target_key_arn
}
