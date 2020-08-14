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

  admin_group_object_ids = ["6c8261f1-ec70-4f7e-a0d3-e10706f25782"]
}