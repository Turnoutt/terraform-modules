resource "azurerm_key_vault" "api-key-vault" {
  name                = "kv-api-${var.api_name}-${var.environment}"
  location            = azurerm_resource_group.api-resource-group.location
  resource_group_name = azurerm_resource_group.api-resource-group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.api-identity.principal_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]

    certificate_permissions = [
      "Get",
      "List",
    ]
  }

  dynamic "access_policy" {
    for_each = length(var.migrations_identity_principal_id) > 0 ? ["migrations"] : []
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = var.migrations_identity_principal_id

      key_permissions = [
        "Get",
        "List",
      ]

      secret_permissions = [
        "Get",
        "List",
      ]

      certificate_permissions = [
        "Get",
        "List",
      ]
    }
  }

  tags = {
    environment = var.environment
    service     = title(var.api_name)
  }
}

