output "repository_url" {
  description = "リポジトリのURL"
  value       = aws_ecr_repository.this.repository_url
}

output "name" {
  description = "リポジトリの名前"
  value       = aws_ecr_repository.this.name
}

output "arn" {
  description = "リポジトリのARN"
  value       = aws_ecr_repository.this.arn
}
