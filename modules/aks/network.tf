
data "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.public_ip_resource_group_name
}

resource "azurerm_virtual_network" "cluster_network" {
  name                = var.virtual_network_name
  location            = local.deployed_location
  resource_group_name = data.azurerm_resource_group.cluster.name
  address_space       = [var.virtual_network_address_prefix]
}

resource "azurerm_subnet" "kubesubnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = azurerm_virtual_network.cluster_network.name
  resource_group_name  = data.azurerm_resource_group.cluster.name
  address_prefixes     = [var.aks_subnet_address_prefix]
}

resource "azurerm_subnet" "appgwsubnet" {
  count                = var.use_app_gateway ? 1 : 0
  name                 = "appgwsubnet" #Hardcoded to this name.
  virtual_network_name = azurerm_virtual_network.cluster_network.name
  resource_group_name  = data.azurerm_resource_group.cluster.name
  address_prefixes     = [var.app_gateway_subnet_address_prefix]
}

