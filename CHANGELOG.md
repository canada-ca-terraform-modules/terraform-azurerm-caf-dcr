# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- Initial scaffold of the `terraform-azurerm-caf-dcr` module wrapping
  `azurerm_monitor_data_collection_rule`.
- Support for all destination types (`azure_monitor_metrics`, `log_analytics`, `event_hub`,
  `event_hub_direct`, `storage_blob`, `storage_blob_direct`, `storage_table_direct`,
  `monitor_account`).
- Support for all data source types (`syslog`, `windows_event_log`, `performance_counter`,
  `windows_firewall_log`, `extension`, `iis_log`, `log_file`, `platform_telemetry`,
  `prometheus_forwarder`, `data_import`).
- Support for `stream_declaration` and `identity` blocks.
- ESLZ wrapper (`ESLZ/DataCollectionRule.tf`) and example tfvars
  (`ESLZ/DataCollectionRule.tfvars`).
- Baseline test coverage (`tests/dcr.tftest.hcl`).
