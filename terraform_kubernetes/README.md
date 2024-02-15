# terraform_kubernetes

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.25.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.25.2 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.gke_team_namespaces](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/namespace) | resource |
| [kubernetes_role.gke_rbac_role_definition](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/role) | resource |
| [kubernetes_role_binding.gke_rbac_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/role_binding) | resource |
| [null_resource.get-credentials](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ghack_cluster_name"></a> [ghack\_cluster\_name](#input\_ghack\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_ops_project"></a> [ops\_project](#input\_ops\_project) | n/a | `string` | n/a | yes |
| <a name="input_ops_region"></a> [ops\_region](#input\_ops\_region) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | prefix for all resources | `string` | n/a | yes |
| <a name="input_teams"></a> [teams](#input\_teams) | teamlist | `list(string)` | <pre>[<br>  "teama",<br>  "teamb",<br>  "zzzz"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
