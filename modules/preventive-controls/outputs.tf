output "enforced_policy_names" {
  description = "List of Organization Policy resource identifiers managed by this module."
  value = [
    google_org_policy_policy.disable_sa_key_creation.name,
    google_org_policy_policy.disable_automatic_iam_grants.name,
    google_org_policy_policy.uniform_bucket_level_access.name,
    google_org_policy_policy.vm_external_ip_access.name,
    google_org_policy_policy.resource_locations.name,
    google_org_policy_policy.require_shielded_vm.name,
    google_org_policy_policy.disable_guest_attributes.name,
    google_org_policy_policy.require_os_login.name
  ]
}