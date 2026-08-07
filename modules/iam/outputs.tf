output "service_account_email" {
  value       = google_service_account.workload_sa.email
  description = "The email of the created workload service account"
}
