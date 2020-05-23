output "key_vault_id" {
    value = azurerm_key_vault.api-key-vault.id
}

output "resource_group_name" {
    value = azurerm_resource_group.api-resource-group.name
}