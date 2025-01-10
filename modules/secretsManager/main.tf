resource "aws_secretsmanager_secret" "this" {
  name = var.name
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}
output "id" {
  description = "The ID of the secret."
  value       = aws_secretsmanager_secret.this.id
}

output "arn" {
  description = "The ARN of the secret."
  value       = aws_secretsmanager_secret.this.arn
}
