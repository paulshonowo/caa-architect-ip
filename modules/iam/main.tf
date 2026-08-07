# Workload Service Account (No static keys)
resource "google_service_account" "workload_sa" {
  account_id   = "sa-schoolgram-${var.environment}-app"
  display_name = "Schoolgram App Service Account (${var.environment})"
  project      = var.project_id
}

# Least-privilege IAM Role Assignments
resource "google_project_iam_member" "log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.workload_sa.email}"
}

resource "google_project_iam_member" "metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.workload_sa.email}"
}
