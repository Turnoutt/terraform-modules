data "azurerm_resource_group" "cluster" {
  name = var.resource_group_name
}

provider "azurerm" {
  version = ">= 2.5.0"
  features {}
}

provider "azuread" {
  version = "~>0.7.0"
}


resource "azurerm_kubernetes_cluster" "cluster" {
  name                       = var.cluster_name
  location                   = data.azurerm_resource_group.cluster.location
  resource_group_name        = data.azurerm_resource_group.cluster.name
  dns_prefix                 = var.dns_prefix
  kubernetes_version         = var.kubernetes_version
  enable_pod_security_policy = false

  dynamic "identity" {
    for_each = var.use_managed_identity ? ["1"] : []
    content {
      type = "SystemAssigned"
    }
  }

  dynamic "service_principal" {
    for_each = var.use_managed_identity ? [] : ["1"]
    content {
      client_id     = azuread_service_principal.kube-sp[0].application_id
      client_secret = azuread_service_principal_password.kube-sp[0].value
    }
  }

  default_node_pool {
    name                = "default"
    vm_size             = var.agent_vm_size
    os_disk_size_gb     = 30
    enable_auto_scaling = true
    availability_zones  = ["1", "2", "3"]
    min_count           = 1
    max_count           = 10
    type                = "VirtualMachineScaleSets"
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_ip
    docker_bridge_cidr = var.docker_cidr
    load_balancer_sku  = "Standard"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      client_app_id     = azuread_application.client-app.application_id
      server_app_id     = azuread_application.server-app.application_id
      server_app_secret = azuread_service_principal_password.server-app.value
    }
  }

  addon_profile {
    http_application_routing {
      enabled = false
    }
  }
}

