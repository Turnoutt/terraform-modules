
resource "azuread_application" "kube-sp" {
  count                      = var.use_managed_identity ? 0 : 1
  name                       = var.service_principal_name
  homepage                   = "https://homepage"
  identifier_uris            = ["https://kube-sp-${var.environment_name}"]
  reply_urls                 = ["https://replyurl"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

resource "azuread_service_principal" "kube-sp" {
  count          = var.use_managed_identity ? 0 : 1
  application_id = azuread_application.kube-sp[0].application_id
}

resource "azuread_service_principal_password" "kube-sp" {
  count                = var.use_managed_identity ? 0 : 1
  service_principal_id = azuread_service_principal.kube-sp[0].id
  value                = "VT=uSgfTanZhyz@%nL9Hpd+Tfay_MRV#"
  end_date             = "2050-01-01T01:02:03Z"
}

data "azurerm_user_assigned_identity" "kube-sp" {
  count               = var.use_managed_identity ? 1 : 0
  name                = "${azurerm_kubernetes_cluster.cluster.name}-agentpool"
  resource_group_name = azurerm_kubernetes_cluster.cluster.node_resource_group
}

data "azurerm_resource_group" "node-group" {
  name = azurerm_kubernetes_cluster.cluster.node_resource_group
}

locals {
  service_principal_id = var.use_managed_identity ? data.azurerm_user_assigned_identity.kube-sp[0].principal_id : azuread_service_principal.kube-sp[0].id
}

# Required permissions for AAD Pod Identity
# The SP needs both of these permissions on the Node RG
resource "azurerm_role_assignment" "aks-identity-contributor-assignment" {
  scope                = data.azurerm_resource_group.node-group.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = local.service_principal_id
}


resource "azurerm_role_assignment" "aks-identity-operator-assignment" {
  scope                = data.azurerm_resource_group.node-group.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = local.service_principal_id
}
