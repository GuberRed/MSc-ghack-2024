# subnets

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.39.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.39.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_subnetwork.subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. Provide this property when you create the resource. This field can be set only at resource creation time. | `string` | `null` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The network this subnet belongs to. Only networks that are in the distributed mode can have subnetworks. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where subnets will be created | `string` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | The purpose of the resource. A subnetwork with purpose set to INTERNAL\_HTTPS\_LOAD\_BALANCER is a user-created subnetwork that is reserved for Internal HTTP(S) Load Balancing. | `string` | `null` | no |
| <a name="input_role"></a> [role](#input\_role) | The role of subnetwork. Currently, this field is only used when purpose = INTERNAL\_HTTPS\_LOAD\_BALANCER. The value can be set to ACTIVE or BACKUP. | `string` | `null` | no |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | Secondary ranges that will be used in some of the subnets | `list(object({ range_name = string, ip_cidr_range = string }))` | `[]` | no |
| <a name="input_subnet_flow_logs_filter_expr"></a> [subnet\_flow\_logs\_filter\_expr](#input\_subnet\_flow\_logs\_filter\_expr) | Export filter used to define which VPC flow logs should be logged, as as CEL expression. | `bool` | `"true"` | no |
| <a name="input_subnet_flow_logs_interval"></a> [subnet\_flow\_logs\_interval](#input\_subnet\_flow\_logs\_interval) | Can only be specified if VPC flow logging for this subnetwork is enabled. Toggles the aggregation interval for collecting flow logs. | `string` | `"INTERVAL_5_SEC"` | no |
| <a name="input_subnet_flow_logs_metadata"></a> [subnet\_flow\_logs\_metadata](#input\_subnet\_flow\_logs\_metadata) | Configures whether metadata fields should be added to the reported VPC flow logs. Default value is INCLUDE\_ALL\_METADATA. Possible values are EXCLUDE\_ALL\_METADATA, INCLUDE\_ALL\_METADATA, and CUSTOM\_METADATA. | `string` | `"INCLUDE_ALL_METADATA"` | no |
| <a name="input_subnet_flow_logs_sampling"></a> [subnet\_flow\_logs\_sampling](#input\_subnet\_flow\_logs\_sampling) | Can only be specified if VPC flow logging for this subnetwork is enabled. The value of the field must be in [0, 1]. | `string` | `"0.5"` | no |
| <a name="input_subnet_ip"></a> [subnet\_ip](#input\_subnet\_ip) | The range of internal addresses that are owned by this subnetwork. | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the resource, provided by the client when initially creating the resource. | `string` | n/a | yes |
| <a name="input_subnet_private_access"></a> [subnet\_private\_access](#input\_subnet\_private\_access) | When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access. | `bool` | `true` | no |
| <a name="input_subnet_region"></a> [subnet\_region](#input\_subnet\_region) | The GCP region for this subnetwork. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ipv6_prefix"></a> [external\_ipv6\_prefix](#output\_external\_ipv6\_prefix) | The range of external IPv6 addresses that are owned by this subnetwork. |
| <a name="output_gateway_address"></a> [gateway\_address](#output\_gateway\_address) | The gateway address for default routes to reach destination addresses outside this subnetwork. |
| <a name="output_ipv6_cidr_range"></a> [ipv6\_cidr\_range](#output\_ipv6\_cidr\_range) | The range of internal IPv6 addresses that are owned by this subnetwork. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | An identifier for the resource with format projects/{{project}}/regions/{{region}}/subnetworks/{{name}} |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The subnet name. |
<!-- END_TF_DOCS -->
