# network

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./networkmodules/subnets | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./networkmodules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compute_region"></a> [compute\_region](#input\_compute\_region) | n/a | `string` | n/a | yes |
| <a name="input_ops_project"></a> [ops\_project](#input\_ops\_project) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_subnet_description"></a> [subnet\_description](#input\_subnet\_description) | Subnet description | `string` | `"subenet description"` | no |
| <a name="input_subnet_range"></a> [subnet\_range](#input\_subnet\_range) | Subnet range | `string` | `"10.20.30.0/24"` | no |
| <a name="input_vpc_network_description"></a> [vpc\_network\_description](#input\_vpc\_network\_description) | VPC network description | `string` | `"VPC Network for Infra challange for ghack2024"` | no |
| <a name="input_vpc_network_routing_mode"></a> [vpc\_network\_routing\_mode](#input\_vpc\_network\_routing\_mode) | VPC network routing mode | `string` | `"REGIONAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | The VPC resource being created |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The ID of the VPC being created |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | The URI of the VPC being created |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | An identifier for the resource with format projects/{{project}}/regions/{{region}}/subnetworks/{{name}} |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The subnet name. |
| <a name="output_subnet_self_link"></a> [subnet\_self\_link](#output\_subnet\_self\_link) | The URI of the created resource. |
<!-- END_TF_DOCS -->
