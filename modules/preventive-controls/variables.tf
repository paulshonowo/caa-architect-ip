variable "org_id" {
  type        = string
  description = "The GCP Organization ID"
}

variable "billing_account" {
  type        = string
  description = "The GCP Billing Account ID"
}

variable "allowed_regions" {
  type        = list(string)
  description = "Allowed GCP regions for organization policy restriction"
  default     = ["in:eu-locations", "in:us-locations"]
}

variable "enable_strict_external_ip_block" {
  type        = bool
  description = "Whether to block external IP creation on VM instances"
  default     = true
}
