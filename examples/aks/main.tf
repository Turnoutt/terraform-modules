module "aks" {
  source = "../../modules/aks"

  resource_group_name  = "rg-example-api-dev"
  cluster_name         = "kube-api-dev"
  dns_prefix           = "example-dev"
  service_cidr         = "10.27.0.0/20"
  dns_ip               = "10.27.0.10"
  agent_vm_size        = "Standard_A4_v2"
  kubernetes_version   = "1.15.7"
  environment_name     = "dev"
  use_managed_identity = true

  active_directory_config = {
    server_app_password = "superstr0ngp@ssword"
    client_app_password = "superstr0ngp@ssword"
  }
}