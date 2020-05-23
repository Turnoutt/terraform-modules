resource "azurerm_user_assigned_identity" "api-identity" {
  name                = "sp-api-${var.api_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.api-resource-group.name
  location            = "West US"
}

resource "azurerm_role_assignment" "aks-identity-assignment" {
  scope                = azurerm_user_assigned_identity.api-identity.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = var.aks_service_principal_id
}
