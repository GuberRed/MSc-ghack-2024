# firewall-rules

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
| [google_compute_firewall.rules](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow"></a> [allow](#input\_allow) | The list of ALLOW rules specified by this firewall. Each rule specifies a protocol and port-range tuple that describes a permitted connection. | `list(any)` | `null` | no |
| <a name="input_deny"></a> [deny](#input\_deny) | The list of DENY rules specified by this firewall. Each rule specifies a protocol and port-range tuple that describes a denied connection. | `list(any)` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. Provide this property when you create the resource. | `string` | `null` | no |
| <a name="input_direction"></a> [direction](#input\_direction) | Direction of traffic to which this firewall applies. | `string` | `"INGRESS"` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | This field denotes whether to include or exclude metadata for firewall logs. Possible values are EXCLUDE\_ALL\_METADATA and INCLUDE\_ALL\_METADATA. | `string` | `"INCLUDE_ALL_METADATA"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource. | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network this set of firewall rules applies to. | `string` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | Priority for this rule. This is an integer between 0 and 65535, both inclusive. | `number` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id of the project that holds the network. | `string` | n/a | yes |
| <a name="input_ranges"></a> [ranges](#input\_ranges) | If ranges are specified, the firewall will apply only to traffic that has source IP address in these ranges. | `list(string)` | `null` | no |
| <a name="input_source_service_accounts"></a> [source\_service\_accounts](#input\_source\_service\_accounts) | If source service accounts are specified, the firewall will apply only to traffic originating from an instance with a service account in this list. | `list(string)` | `null` | no |
| <a name="input_source_tags"></a> [source\_tags](#input\_source\_tags) | If source tags are specified, the firewall will apply only to traffic with source IP that belongs to a tag listed in source tags. | `list(string)` | `null` | no |
| <a name="input_target_service_accounts"></a> [target\_service\_accounts](#input\_target\_service\_accounts) | A list of service accounts indicating sets of instances located in the network that may make network connections as specified in allowed. | `list(string)` | `null` | no |
| <a name="input_target_tags"></a> [target\_tags](#input\_target\_tags) | A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_rules"></a> [firewall\_rules](#output\_firewall\_rules) | The created firewall rule resources |
<!-- END_TF_DOCS -->
