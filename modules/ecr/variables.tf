variable "prefix" {
  description = "プレフィックス"
  type        = string
}

variable "force_delete" {
  description = "イメージを含むリポジトリを強制的に削除するか"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "KMS鍵のARN"
  type        = string
}

variable "holding_image_count" {
  description = "保持するイメージの数"
  type        = number
  default     = 10
}
