variable "project_id" {
  type        = string
  description = "Target GCP Project ID for IAM bindings"
}

variable "environment" {
  type        = string
  description = "Environment identifier (e.g. prod, staging)"
  default     = "prod"
}
