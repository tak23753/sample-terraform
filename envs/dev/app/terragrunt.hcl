include "root" {
  path = find_in_parent_folders()
}

dependency "security" {
  config_path = "../security"

  mock_outputs_merge_strategy_with_state = "shallow"
  mock_outputs = {
    log_kms_key_arn = "arn:aws:kms:ap-northeast-1:123456789012:key/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
    ecr_kms_key_arn = "arn:aws:kms:ap-northeast-1:123456789012:key/bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
  }
}

inputs = {
  log_kms_key_arn                       = dependency.security.outputs.log_kms_key_arn
  ecr_kms_key_arn                       = dependency.security.outputs.ecr_kms_key_arn
}
