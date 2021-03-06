locals {
  backend_address_pool_name      = "${azurerm_virtual_network.cluster_network.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.cluster_network.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.cluster_network.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.cluster_network.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.cluster_network.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.cluster_network.name}-rqrt"

  #networkContributorRole         = "[concat('/subscriptions/', subscription().subscriptionId, '/providers/Microsoft.Authorization/roleDefinitions/', '4d97b98b-1d4f-4787-a291-c67834d212e7')]"

  app_gateway_subnet_name = "appgwsubnet"
}

resource "azurerm_application_gateway" "network" {
  count = var.use_app_gateway ? 1 : 0

  name                = var.app_gateway_name
  resource_group_name = data.azurerm_resource_group.cluster.name
  location            = local.deployed_location

  sku {
    name = var.app_gateway_sku
    tier = "Standard_v2"
  }

  autoscale_configuration {
    max_capacity = 10
    min_capacity = 0
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.appgwsubnet[0].id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  depends_on = [
    azurerm_virtual_network.cluster_network,
    data.azurerm_public_ip.public_ip,
  ]

  lifecycle {
    ignore_changes = [
      tags,
      http_listener,
      backend_http_settings,
      request_routing_rule,
      backend_address_pool,
      probe,
      ssl_certificate,
      frontend_port
    ]
  }
}
