## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azuread | ~>0.7.0 |
| azurerm | >= 2.5.0 |

## Providers

| Name | Version |
|------|---------|
| azuread | ~>0.7.0 |
| azurerm | >= 2.5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_group\_object\_ids | n/a | `list(string)` | n/a | yes |
| agent\_vm\_count | n/a | `string` | `"2"` | no |
| agent\_vm\_size | n/a | `string` | `"Standard_D2s_v3"` | no |
| cluster\_name | n/a | `string` | n/a | yes |
| dns\_ip | should be the .10 address of your service IP address range | `string` | `"10.0.0.10"` | no |
| dns\_prefix | n/a | `string` | n/a | yes |
| docker\_cidr | IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Default of 172.17.0.1/16. | `string` | `"172.17.0.1/16"` | no |
| enable\_virtual\_node\_addon | n/a | `bool` | `false` | no |
| environment\_name | dev, prod, staging, etc. | `string` | n/a | yes |
| kubernetes\_version | n/a | `string` | `"1.15.5"` | no |
| network\_plugin | Network plugin used by AKS. Either azure or kubenet. | `string` | `"azure"` | no |
| network\_policy | Network policy to be used with Azure CNI. Either azure or calico. | `string` | `"azure"` | no |
| resource\_group\_name | n/a | `string` | n/a | yes |
| service\_cidr | Used to assign internal services in the AKS cluster an IP address. This IP address range should be an address space that isn't in use elsewhere in your network environment. This includes any on-premises network ranges if you connect, or plan to connect, your Azure virtual networks using Express Route or a Site-to-Site VPN connections. | `string` | `"10.0.0.0/16"` | no |
| service\_principal\_name | The name of the service principal to be created for the cluster. If you are not using managed identity, this is required. | `string` | `""` | no |
| use\_managed\_identity | n/a | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| client\_certificate | n/a |
| client\_key | n/a |
| cluster\_ca\_certificate | n/a |
| host | n/a |
| kube\_config | The raw admin kube config to be used in later downstream modules. |
| kubernetes\_cluster\_id | n/a |
| service\_principal | n/a |

