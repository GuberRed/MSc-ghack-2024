# gke

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.ghack_cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.ghack_cluster_node_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ops_network"></a> [ops\_network](#input\_ops\_network) | n/a | `string` | n/a | yes |
| <a name="input_ops_project"></a> [ops\_project](#input\_ops\_project) | n/a | `string` | n/a | yes |
| <a name="input_ops_region"></a> [ops\_region](#input\_ops\_region) | n/a | `string` | n/a | yes |
| <a name="input_ops_subnetwork"></a> [ops\_subnetwork](#input\_ops\_subnetwork) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output_cluster_name"></a> [output\_cluster\_name](#output\_output\_cluster\_name) | n/a |
<!-- END_TF_DOCS -->
