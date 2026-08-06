# Prevent creation of static service account JSON keys
resource "google_org_policy_policy" "disable_sa_key_creation" {
  name   = "organizations/${var.org_id}/policies/iam.disableServiceAccountKeyCreation"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = "TRUE"
    }
  }
}

# Block automatic IAM grant of Editor/Owner roles to default service accounts
resource "google_org_policy_policy" "disable_default_sa_automatic_iam" {
  name   = "organizations/${var.org_id}/policies/iam.automaticIamGrantsForDefaultServiceAccounts"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = "TRUE"
    }
  }
}

# Enforce Uniform Bucket-Level Access across all GCS buckets
resource "google_org_policy_policy" "enforce_uniform_bucket_level_access" {
  name   = "organizations/${var.org_id}/policies/storage.uniformBucketLevelAccess"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = "TRUE"
    }
  }
}

# Restrict allowed GCP resource deployment regions
resource "google_org_policy_policy" "restrict_locations" {
  name   = "organizations/${var.org_id}/policies/gcp.resourceLocations"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      values {
        allowed_values = var.allowed_regions
      }
    }
  }
}

# Restrict VM Public IP assignment (if enabled by variable)
resource "google_org_policy_policy" "vm_external_ip_access" {
  count  = var.enable_strict_external_ip_block ? 1 : 0
  name   = "organizations/${var.org_id}/policies/compute.vmExternalIpAccess"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      deny_all = "TRUE"
    }
  }
}