output "dcr_object" {
  description = "Outputs the entire Data Collection Rule object"
  value       = azurerm_monitor_data_collection_rule.dcr
}

output "dcr_name" {
  description = "Outputs the name of the Data Collection Rule"
  value       = azurerm_monitor_data_collection_rule.dcr.name
}

output "dcr_id" {
  description = "Outputs the id of the Data Collection Rule"
  value       = azurerm_monitor_data_collection_rule.dcr.id
}

output "dcr_immutable_id" {
  description = "Outputs the immutable id of the Data Collection Rule"
  value       = azurerm_monitor_data_collection_rule.dcr.immutable_id
}
