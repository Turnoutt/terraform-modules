variable "resource_group_name" {
  type = string
}

variable "environment_name" {
  type        = string
  description = "dev, prod, staging, etc."
}

variable "cluster_name" {
  type = string
}

variable "cluster_location" {
  type    = string
  default = ""
}

variable "dns_prefix" {
  type = string
}

variable "agent_vm_count" {
  type    = string
  default = "2"
}

variable "agent_vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "kubernetes_version" {
  type    = string
  default = "1.15.5"
}

variable "enable_virtual_node_addon" {
  type    = bool
  default = false
}

variable "service_cidr" {
  default     = "10.0.0.0/16"
  description = "Used to assign internal services in the AKS cluster an IP address. This IP address range should be an address space that isn't in use elsewhere in your network environment. This includes any on-premises network ranges if you connect, or plan to connect, your Azure virtual networks using Express Route or a Site-to-Site VPN connections."
  type        = string
}

variable "dns_ip" {
  default     = "10.0.0.10"
  description = "should be the .10 address of your service IP address range"
  type        = string
}

variable "docker_cidr" {
  default     = "172.17.0.1/16"
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Default of 172.17.0.1/16."
}

variable "virtual_network_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "15.0.0.0/8"
}

variable "virtual_network_name" {
  description = "Virtual network name"
  default     = "aksVirtualNetwork"
}

variable "aks_subnet_name" {
  description = "AKS Subnet Name."
  default     = "kubesubnet"
}

variable "aks_subnet_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "15.0.0.0/16"
}

variable "app_gateway_subnet_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "15.1.0.0/16"
}

variable "network_plugin" {
  default     = "azure"
  description = "Network plugin used by AKS. Either azure or kubenet."
}
variable "network_policy" {
  default     = "azure"
  description = "Network policy to be used with Azure CNI. Either azure or calico."
}

variable "service_principal_name" {
  type        = string
  description = "The name of the service principal to be created for the cluster. If you are not using managed identity, this is required."
  default     = ""

  # Waiting for better validation to roll out
  # validation {
  #   condition     = var.use_managed_identity == false && length(var.service_principal_name) == 0
  #   error_message = "If you are not using managed identity, the Service Principal Name is required."
  # }
}

variable "use_managed_identity" {
  type    = bool
  default = true
}

variable "admin_group_object_ids" {
  type = list(string)
}

variable "log_analytics_name" {
  description = "Name of the Log Analytics Workspace."
  default     = "la-kube"
}

variable "log_analytics_sku" {
  description = "Specified the Sku of the Log Analytics Workspace."
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The workspace data retetion in days. Possible values range between 30 and 730."
  default     = 30
}

variable "use_log_analytics" {
  type    = bool
  default = false
}

variable "app_gateway_sku" {
  description = "Name of the Application Gateway SKU."
  default     = "Standard_v2"
}

variable "app_gateway_tier" {
  description = "Tier of the Application Gateway SKU."
  default     = "Standard_v2"
}

variable "app_gateway_name" {
  description = "Name of the Application Gateway."
}

variable "public_ip_name" {
  type = string
}

variable "use_app_gateway" {
  type    = bool
  default = true
}

variable "public_ip_resource_group_name" {
  type = string
}
