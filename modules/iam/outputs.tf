output "service_account_email" {
  description = "Email of the keyless CI/CD workload service account."
  value       = google_service_account.cicd_sa.email
}

output "service_account_name" {
  description = "Fully qualified resource identifier of the CI/CD service account."
  value       = google_service_account.cicd_sa.name
}

output "wif_pool_name" {
  description = "Resource name of the Workload Identity Pool."
  value       = google_iam_workload_identity_pool.github_pool.name
}

output "wif_provider_name" {
  description = "Resource identifier of the Workload Identity Pool Provider."
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}