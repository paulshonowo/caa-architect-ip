variable "project_id" {
  type        = string
  description = "The GCP Project ID where networking resources are created"
}

variable "region" {
  type        = string
  description = "Primary region for network resources"
  default     = "europe-west1"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "schoolgram-prod-vpc"
}

variable "subnet_cidr" {
  type        = string
  description = "Primary CIDR block for application workloads"
  default     = "10.0.1.0/24"
}

variable "pods_cidr" {
  type        = string
  description = "Secondary CIDR block for GKE Pods"
  default     = "10.100.0.0/16"
}

variable "services_cidr" {
  type        = string
  description = "Secondary CIDR block for GKE Services"
  default     = "10.200.0.0/20"
}
