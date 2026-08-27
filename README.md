# terraform-azurerm-caf-dcr

Deploys an Azure Monitor Data Collection Rule (`azurerm_monitor_data_collection_rule`),
covering every destination type, data source type, stream declaration, and identity
supported by the resource. Requires azurerm `~> 5.0`.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 5.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_data_collection_rule.dcr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dcr"></a> [dcr](#input\_dcr) | Data Collection Rule object containing all parameters. Supported properties include (but are not limited to):<br/>  - resource\_group (Required): key in resource\_groups map, or a full resource group ID<br/>  - kind (Optional): Linux, Windows, AgentDirectToStore, WorkspaceTransforms<br/>  - description (Optional)<br/>  - data\_collection\_endpoint\_id (Optional)<br/>  - destinations (Required): object with azure\_monitor\_metrics, log\_analytics, event\_hub,<br/>    event\_hub\_direct, storage\_blob, storage\_blob\_direct, storage\_table\_direct, monitor\_account<br/>  - data\_flow (Required): list of data flow objects (streams, destinations, ...)<br/>  - data\_sources (Optional): object with syslog, windows\_event\_log, performance\_counter,<br/>    windows\_firewall\_log, extension, iis\_log, log\_file, platform\_telemetry,<br/>    prometheus\_forwarder, data\_import<br/>  - stream\_declaration (Optional): map of custom stream definitions<br/>  - identity (Optional)<br/>  - tags (Optional) | `any` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) Environment for the Data Collection Rule | `string` | n/a | yes |
| <a name="input_group"></a> [group](#input\_group) | (Required) Group for the project | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) specifies the Azure location where the resource exists | `string` | `"canadacentral"` | no |
| <a name="input_project"></a> [project](#input\_project) | (Required) Project name | `string` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | (Required) Resource group object for the Data Collection Rule | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the resources | `map(string)` | `{}` | no |
| <a name="input_userDefinedString"></a> [userDefinedString](#input\_userDefinedString) | (Required) UserDefinedString for the Data Collection Rule | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dcr_id"></a> [dcr\_id](#output\_dcr\_id) | Outputs the id of the Data Collection Rule |
| <a name="output_dcr_immutable_id"></a> [dcr\_immutable\_id](#output\_dcr\_immutable\_id) | Outputs the immutable id of the Data Collection Rule |
| <a name="output_dcr_name"></a> [dcr\_name](#output\_dcr\_name) | Outputs the name of the Data Collection Rule |
| <a name="output_dcr_object"></a> [dcr\_object](#output\_dcr\_object) | Outputs the entire Data Collection Rule object |
<!-- END_TF_DOCS -->
