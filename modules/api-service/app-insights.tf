resource "azurerm_application_insights" "api-insights" {
  name                = "tf-api-${var.api_name}-${var.environment}"
  location            = "West US"
  resource_group_name = azurerm_resource_group.api-resource-group.name
  application_type    = "web"
  sampling_percentage = 1
  retention_in_days   = 30

  tags = {
    environment = title(var.environment)
    service     = title(var.api_name)
  }
}

resource "azurerm_key_vault_secret" "app-insights" {
  name         = "ApplicationInsights--InstrumentationKey"
  value        = azurerm_application_insights.api-insights.instrumentation_key
  key_vault_id = azurerm_key_vault.api-key-vault.id

  tags = {
    environment = title(var.environment)
    service     = title(var.api_name)
  }
}

