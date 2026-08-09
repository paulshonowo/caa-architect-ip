# Workload Identity Pool for Keyless CI/CD
resource "google_iam_workload_identity_pool" "github_pool" {
  project                   = var.project_id
  workload_identity_pool_id = "${var.prefix}-github-pool"
  display_name              = "GitHub Actions WIF Pool"
  description               = "Identity Pool for keyless GitHub Actions deployments"
}

# OIDC Provider Configuration
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "${var.prefix}-github-provider"
  display_name                       = "GitHub Actions OIDC Provider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
    "attribute.owner"      = "assertion.repository_owner"
  }

  attribute_condition = "assertion.repository_owner == '${var.github_org}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# Workload Service Account for Pipeline Execution
resource "google_service_account" "cicd_sa" {
  project      = var.project_id
  account_id   = "${var.prefix}-cicd-sa"
  display_name = "Keyless CI/CD Pipeline Execution Service Account"
}

# Least-Privilege Role Bindings
resource "google_project_iam_member" "log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cicd_sa.email}"
}

resource "google_project_iam_member" "metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cicd_sa.email}"
}

# External OIDC Binding to Service Account
resource "google_service_account_iam_member" "wif_sa_binding" {
  service_account_id = google_service_account.cicd_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.github_org}/${var.github_repo}"
}

# Privileged Access Management (PAM) / Just-In-Time (JIT) Scaffolding with Conditional Expiry
resource "google_project_iam_member" "jit_security_admin" {
  count   = var.jit_approver_principal != "" ? 1 : 0
  project = var.project_id
  role    = "roles/iam.securityAdmin"
  member  = var.jit_approver_principal

  condition {
    title       = "JIT_Temporary_Elevated_Access"
    description = "Enforces time-bound Just-In-Time privilege escalation."
    expression  = "request.time < timestamp('${var.jit_expiry_timestamp}')"
  }
}