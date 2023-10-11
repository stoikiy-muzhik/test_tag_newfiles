resource "azurerm_storage_account" "storageaccount" {
  name                              = var.storage_account_name
  resource_group_name               = local.resource_group_name
  allow_nested_items_to_be_public   = false
  cross_tenant_replication_enabled  = false
  infrastructure_encryption_enabled = true
  min_tls_version                   = var.min_tls_version
  tags = merge(local.common_tags, local.extra_tags, {
    git_org   = "stoikiy-muzhik"
    yor_trace = "58627dd1-229d-4257-9f69-6d3603c73c6f"
  })

  dynamic "blob_properties" {
    for_each = var.is_hns_enabled ? [] : ["true"]
    content {
      delete_retention_policy {
        days = var.soft_delete_retention
      }
    }
  }
}