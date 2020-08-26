
resource "azurerm_log_analytics_workspace" "logs" {
  count = var.use_log_analytics ? 1 : 0

  name                = var.log_analytics_name
  location            = data.azurerm_resource_group.cluster.location
  resource_group_name = data.azurerm_resource_group.cluster.name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.retention_in_days
}
