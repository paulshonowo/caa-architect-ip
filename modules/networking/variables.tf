variable "project_id" {
  description = "The GCP Project ID where network resources will be created."
  type        = string
}

variable "prefix" {
  description = "Resource prefix for naming conventions."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., prod, stage, dev)."
  type        = string
}

variable "region" {
  description = "GCP Region for subnets, routers, and NAT gateways."
  type        = string
}

variable "subnet_cidr" {
  description = "Primary CIDR block for application workload subnet."
  type        = string
  default     = "10.100.0.0/20"
}

variable "pods_cidr" {
  description = "Secondary CIDR block reserved for GKE Pods."
  type        = string
  default     = "10.101.0.0/16"
}

variable "services_cidr" {
  description = "Secondary CIDR block reserved for GKE Services."
  type        = string
  default     = "10.102.0.0/20"
}

variable "nat_log_level" {
  description = "Logging specification level for Cloud NAT (ERRORS_ONLY, ALL, or NONE)."
  type        = string
  default     = "ALL"
}

variable "access_policy_title" {
  description = "Title for the Access Context Manager policy."
  type        = string
  default     = "Organization Security Perimeter Policy"
}

variable "vpc_sc_dry_run" {
  description = "Toggle dry-run mode for VPC Service Controls perimeter."
  type        = bool
  default     = false
}

variable "protected_services" {
  description = "List of GCP APIs restricted within the VPC-SC perimeter."
  type        = list(string)
  default = [
    "storage.googleapis.com",
    "bigquery.googleapis.com"
  ]
}