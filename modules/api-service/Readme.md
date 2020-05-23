## Requirements

| Name | Version |
|------|---------|
| azurerm | >= 2.5.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aks\_service\_principal\_id | The service principal Id of the Kubernetes Cluster | `string` | n/a | yes |
| api\_name | The name of the Api. This will be used to generate other names in the module so don't use any spaces or special characters | `string` | n/a | yes |
| environment | dev, prod, staging, etc. | `string` | n/a | yes |
| migrations\_identity\_principal\_id | The service principal Id of the identity used for running migrations. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_vault\_id | n/a |
| resource\_group\_name | n/a |
| service\_identity\_principal\_id | n/a |
| tenant\_id | n/a |

