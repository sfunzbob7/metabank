variable "bucket_name" {
  description = "bucket name"
  type        = string
  sensitive   = true
  default     = "metabank-terraform-status"
}

variable "dynamodb_table_name" {
  description = "dynamodb name"
  type        = string
  sensitive   = true
  default     = "metabank-terraform-locks"
}