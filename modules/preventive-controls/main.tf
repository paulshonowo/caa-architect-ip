# 1. Disable SA Key Creation
resource "google_org_policy_policy" "disable_sa_key_creation" {
  name   = "organizations/${var.org_id}/policies/iam.disableServiceAccountKeyCreation"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = var.enforce_policies ? "TRUE" : "FALSE"
    }
  }
}

# 2. Disable Automatic IAM Grants for Default Service Accounts
resource "google_org_policy_policy" "disable_automatic_iam_grants" {
  name   = "organizations/${var.org_id}/policies/iam.automaticIamGrantsForDefaultServiceAccounts"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = var.enforce_policies ? "TRUE" : "FALSE"
    }
  }
}

# 3. Uniform Bucket-Level Access
resource "google_org_policy_policy" "uniform_bucket_level_access" {
  name   = "organizations/${var.org_id}/policies/storage.uniformBucketLevelAccess"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = var.enforce_policies ? "TRUE" : "FALSE"
    }
  }
}

# 4. Disable VM External IP Access
resource "google_org_policy_policy" "vm_external_ip_access" {
  name   = "organizations/${var.org_id}/policies/compute.vmExternalIpAccess"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      deny_all = var.enforce_policies ? "TRUE" : "FALSE"
    }
  }
}

# 5. Restrict Resource Locations
resource "google_org_policy_policy" "resource_locations" {
  name   = "organizations/${var.org_id}/policies/gcp.resourceLocations"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      values {
        allowed_values = var.allowed_locations
      }
    }
  }
}

# 6. Require Shielded VMs
resource "google_org_policy_policy" "require_shielded_vm" {
  name   = "organizations/${var.org_id}/policies/compute.requireShieldedVm"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = var.enforce_policies ? "TRUE" : "FALSE"
    }
  }
}

# 7. Disable Guest Attributes Access
resource "google_org_policy_policy" "disable_guest_attributes" {
  name   = "organizations/${var.org_id}/policies/compute.disableGuestAttributesAccess"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = var.enforce_policies ? "TRUE" : "FALSE"
    }
  }
}

# 8. Require OS Login
resource "google_org_policy_policy" "require_os_login" {
  name   = "organizations/${var.org_id}/policies/compute.requireOsLogin"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = var.enforce_policies ? "TRUE" : "FALSE"
    }
  }
}