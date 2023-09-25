data "azurerm_resource_group" "this" {
  name = var.rg_name
}

resource "azurerm_storage_account" "this" {
  name                     = lower("${var.env}${var.sa_name}")
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  access_tier              = var.access_tier
  # Force https traffic only
  enable_https_traffic_only = true
  # Restricts network access to internal only
  public_network_access_enabled = false
  tags = {
    Billable   = "false"
    Department = "Networking"
  }
}

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id = azurerm_storage_account.this.id

  default_action = var.network_rule_default_action
  ip_rules       = var.network_rule_ip_rules
  bypass         = ["Metrics", "Logging"]
}