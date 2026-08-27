variable "env" {
  description = "(Required) Environment for the Data Collection Rule"
  type        = string
}

variable "group" {
  description = "(Required) Group for the project"
  type        = string
}

variable "project" {
  description = "(Required) Project name"
  type        = string
}

variable "userDefinedString" {
  description = "(Required) UserDefinedString for the Data Collection Rule"
  type        = string
}

variable "location" {
  description = "(Required) specifies the Azure location where the resource exists"
  type        = string
  default     = "canadacentral"
}

variable "resource_groups" {
  description = "(Required) Resource group object for the Data Collection Rule"
  type        = any
}

variable "dcr" {
  description = <<EOT
Data Collection Rule object containing all parameters. Supported properties include (but are not limited to):
  - resource_group (Required): key in resource_groups map, or a full resource group ID
  - kind (Optional): Linux, Windows, AgentDirectToStore, WorkspaceTransforms
  - description (Optional)
  - data_collection_endpoint_id (Optional)
  - destinations (Required): object with azure_monitor_metrics, log_analytics, event_hub,
    event_hub_direct, storage_blob, storage_blob_direct, storage_table_direct, monitor_account
  - data_flow (Required): list of data flow objects (streams, destinations, ...)
  - data_sources (Optional): object with syslog, windows_event_log, performance_counter,
    windows_firewall_log, extension, iis_log, log_file, platform_telemetry,
    prometheus_forwarder, data_import
  - stream_declaration (Optional): map of custom stream definitions
  - identity (Optional)
  - tags (Optional)
EOT
  type        = any
  default     = {}
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
}
