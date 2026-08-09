variable "project_id" {
  description = "Target GCP Project ID for IAM identity deployments."
  type        = string
}

variable "prefix" {
  description = "Resource prefix."
  type        = string
}

variable "github_org" {
  description = "GitHub Organization authorized for Workload Identity Federation."
  type        = string
}

variable "github_repo" {
  description = "GitHub Repository authorized for Workload Identity Federation."
  type        = string
}

variable "jit_expiry_timestamp" {
  description = "RFC3339 timestamp determining the expiration cutoff for JIT privileges."
  type        = string
  default     = "2026-12-31T23:59:59Z"
}

variable "jit_approver_principal" {
  description = "Principal identity eligible for conditional JIT role binding (e.g., user:admin@domain.com)."
  type        = string
  default     = ""
}