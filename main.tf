data azurerm_resource_group this {
    name = var.rg_name
}

resource "azurerm_storage_account" "this" {
  name                     = lower("${var.env}-${var.sa_name}")
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_account_network_rules" "this" {
  for_each = var.network_rules
  storage_account_id = azurerm_storage_account.this.id

  default_action             = each.value.action
  ip_rules                   = each.value.rules
  bypass                     = ["Metrics","Logging"]
}