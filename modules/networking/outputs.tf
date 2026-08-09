output "vpc_id" {
  description = "The URI of the created VPC."
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "The name of the created VPC."
  value       = google_compute_network.vpc.name
}

output "subnet_id" {
  description = "The URI of the application subnet."
  value       = google_compute_subnetwork.app_subnet.id
}

output "subnet_name" {
  description = "The name of the application subnet."
  value       = google_compute_subnetwork.app_subnet.name
}

output "service_perimeter_name" {
  description = "Fully qualified name of the VPC Security Perimeter."
  value       = google_access_context_manager_service_perimeter.perimeter.name
}