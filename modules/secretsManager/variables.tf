variable "name" {
  description = "The name of the secret."
  type        = string
}

variable "secret_string" {
  description = "The secret string stored in Secrets Manager."
  type        = string
}
