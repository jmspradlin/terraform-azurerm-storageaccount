variable env {
  type        = string
  default     = "dev"
  description = "The environment level (DEV, TEST, PROD)"
}
variable rg_name {
  type        = string
  default     = ""
  description = "Name for the existing Resource Group"
}
variable sa_name {
  type        = string
  default     = ""
  description = "Name for the Storage Account. Must meet DNS naming requirements"
}
variable account_tier {
  type        = string
  default     = "Standard"
  description = "Defines the Tier to use for this storage account."
}
variable account_replication_type {
  type        = string
  default     = "LRS"
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS"
}
variable network_rules {
  type = map
}