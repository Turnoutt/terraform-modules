output "key_vault_id" {
  value = azurerm_key_vault.api-key-vault.id
}

output "resource_group_name" {
  value = azurerm_resource_group.api-resource-group.name
}

output "service_identity_principal_id" {
  value = azurerm_user_assigned_identity.api-identity.principal_id
}

output "service_identity_client_id" {
  value = azurerm_user_assigned_identity.api-identity.client_id
}

output "service_identity_id" {
  value = azurerm_user_assigned_identity.api-identity._id
}
