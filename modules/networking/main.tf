# VPC Network (Custom Mode)
resource "google_compute_network" "vpc" {
  name                    = "${var.prefix}-${var.environment}-vpc"
  project                 = var.project_id
  auto_create_subnetworks = false
}

# Private Subnet with Secondary IP Ranges for GKE
resource "google_compute_subnetwork" "app_subnet" {
  name                     = "${var.prefix}-${var.environment}-app-subnet"
  project                  = var.project_id
  region                   = var.region
  network                  = google_compute_network.vpc.id
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = var.services_cidr
  }
}

# Cloud Router
resource "google_compute_router" "router" {
  name    = "${var.prefix}-${var.environment}-router"
  project = var.project_id
  region  = var.region
  network = google_compute_network.vpc.id
}

# Cloud NAT Gateway
resource "google_compute_router_nat" "nat" {
  name                               = "${var.prefix}-${var.environment}-nat"
  project                            = var.project_id
  region                             = var.region
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = var.nat_log_level != "NONE"
    filter = var.nat_log_level == "NONE" ? "ERRORS_ONLY" : var.nat_log_level
  }
}

# Firewall Rule: Allow Ingress strictly from GCP Identity-Aware Proxy (IAP) CIDR
resource "google_compute_firewall" "allow_iap_ssh" {
  name        = "${var.prefix}-${var.environment}-allow-iap-ssh"
  project     = var.project_id
  network     = google_compute_network.vpc.name
  description = "Allow inbound SSH traffic exclusively via GCP Identity-Aware Proxy."
  direction   = "INGRESS"
  priority    = 1000

  source_ranges = ["35.235.240.0/20"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Access Context Manager Policy
resource "google_access_context_manager_access_policy" "policy" {
  parent = "organizations/${var.project_id}" # Expects numeric org ID if elevated, or project context
  title  = var.access_policy_title
}

# VPC Service Controls Perimeter
resource "google_access_context_manager_service_perimeter" "perimeter" {
  parent         = "accessPolicies/${google_access_context_manager_access_policy.policy.name}"
  name           = "accessPolicies/${google_access_context_manager_access_policy.policy.name}/servicePerimeters/${var.prefix}_${var.environment}_perimeter"
  title          = "${var.prefix}-${var.environment}-perimeter"
  perimeter_type = "PERIMETER_TYPE_REGULAR"

  spec {
    resources = ["projects/${var.project_id}"]
    restricted_services = var.vpc_sc_dry_run ? [] : var.protected_services
  }

  dynamic "use_explicit_dry_run_spec" {
    for_each = var.vpc_sc_dry_run ? [1] : []
    content {
      status {
        resources           = ["projects/${var.project_id}"]
        restricted_services = var.protected_services
      }
    }
  }
}