variable "org_id" {
  description = "The numeric GCP Organization ID where policy rules will be enforced."
  type        = string
}

variable "enforce_policies" {
  description = "Global boolean toggle to enforce boolean org policies."
  type        = bool
  default     = true
}

variable "allowed_locations" {
  description = "List of allowed physical locations for GCP resource deployment."
  type        = list(string)
  default     = ["in:eu-locations"]
}