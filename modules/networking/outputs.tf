output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "The ID of the created VPC"
}

output "subnet_id" {
  value       = google_compute_subnetwork.app_subnet.id
  description = "The ID of the private application subnet"
}

output "subnet_name" {
  value       = google_compute_subnetwork.app_subnet.name
  description = "The name of the private application subnet"
}
