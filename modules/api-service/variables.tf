variable "api_name" {
  type        = string
  description = "The name of the Api. This will be used to generate other names in the module so don't use any spaces or special characters"
}

variable "aks_service_principal_id" {
  type        = string
  description = "The service principal Id of the Kubernetes Cluster"
}

variable "environment" {
  type        = string
  description = "dev, prod, staging, etc."
}

variable "region" {
  type        = string
  description = "dev, prod, staging, etc."
  default     = "West US 2"
}

variable "migrations_identity_principal_id" {
  type        = string
  default     = ""
  description = "The service principal Id of the identity used for running migrations."
}
