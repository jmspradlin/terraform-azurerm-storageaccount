data azurerm_resource_group this {
    name = "${var.env}-${var.rg_name}"
}

resource "azurerm_storage_account" "this" {
  name                     = lower("${var.env}-${var.sa_name}")
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id = azurerm_storage_account.this.id

  default_action             = "Allow"
  ip_rules                   = ["127.0.0.1"]
  bypass                     = ["Metrics","Logging"]
}