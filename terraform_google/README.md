# terraform_google

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.15.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke_ghack_cluster"></a> [gke\_ghack\_cluster](#module\_gke\_ghack\_cluster) | ./modules/gke | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_projects_teams"></a> [projects\_teams](#module\_projects\_teams) | ./modules/team-sa | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_service.api_gke_enable](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_credentials"></a> [credentials](#input\_credentials) | Credentials for gcs SA impersonation | `any` | n/a | yes |
| <a name="input_ops_project"></a> [ops\_project](#input\_ops\_project) | n/a | `string` | n/a | yes |
| <a name="input_ops_region"></a> [ops\_region](#input\_ops\_region) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | prefix for all resources | `string` | n/a | yes |
| <a name="input_teams"></a> [teams](#input\_teams) | teamlist | `list(string)` | <pre>[<br>  "teama",<br>  "teamb",<br>  "zzzz"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_prefix"></a> [prefix](#output\_prefix) | n/a |
<!-- END_TF_DOCS -->
