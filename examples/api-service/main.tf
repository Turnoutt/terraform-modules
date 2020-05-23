
module "service" {
  source = "../../modules/api-service"

  aks_service_principal_id         = "25daada0-709c-41be-b15e-bef2fd3d4d01"
  api_name                         = "foo"
  environment                      = "dev"
  migrations_identity_principal_id = "022686da-61d6-4c02-85a1-40d58ce9865d"
}