variable "prefix" {
  description = "プレフィックス"
  type        = string
}

variable "function_dir_path" {
  description = "Lambda関数ディレクトリへの絶対パス"
  type        = string
}

variable "timeout" {
  description = "Lambdaのタイムアウト時間(秒)"
  type        = number
  default     = 10
}

variable "log_kms_key_arn" {
  description = "ログ暗号化用のKMSキーのarn"
  type        = string
}

variable "ecr_kms_key_arn" {
  description = "ECRイメージ暗号化用のKMSキーのarn"
  type        = string
}
