output "client_certificate" {
  sensitive = true
  value     = "${azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_certificate}"
}

output "client_key" {
  sensitive = true
  value     = "${azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_key}"
}

output "cluster_ca_certificate" {
  sensitive = true
  value     = "${azurerm_kubernetes_cluster.cluster.kube_admin_config.0.cluster_ca_certificate}"
}

output "host" {
  sensitive = false
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.host
}

output "kube_config" {
  sensitive   = true
  description = "The raw admin kube config to be used in later downstream modules."
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config_raw
}

output "kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.cluster.id
}

output "service_principal" {
  value = local.service_principal_id
}