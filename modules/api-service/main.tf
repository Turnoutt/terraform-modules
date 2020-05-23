data "azurerm_client_config" "current" {
}

provider "azurerm" {
  version = ">= 2.5.0"
  features {}
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_resource_group" "api-resource-group" {
  name     = "rg-api-${var.api_name}-${var.environment}"
  location = "West US 2"
}
