resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = local.dcr_name
  resource_group_name = local.resource_group_name
  location            = var.location

  # Optional top-level parameters
  data_collection_endpoint_id = try(var.dcr.data_collection_endpoint_id, null)
  description                 = try(var.dcr.description, null)
  kind                        = try(var.dcr.kind, null)

  destinations {
    dynamic "azure_monitor_metrics" {
      for_each = try(var.dcr.destinations.azure_monitor_metrics, null) != null ? [1] : []
      content {
        name = var.dcr.destinations.azure_monitor_metrics.name
      }
    }

    dynamic "log_analytics" {
      for_each = try(var.dcr.destinations.log_analytics, {})
      content {
        name                  = log_analytics.key
        workspace_resource_id = log_analytics.value.workspace_resource_id
      }
    }

    dynamic "event_hub" {
      for_each = try(var.dcr.destinations.event_hub, {})
      content {
        name         = event_hub.key
        event_hub_id = event_hub.value.event_hub_id
      }
    }

    dynamic "event_hub_direct" {
      for_each = try(var.dcr.destinations.event_hub_direct, {})
      content {
        name         = event_hub_direct.key
        event_hub_id = event_hub_direct.value.event_hub_id
      }
    }

    dynamic "storage_blob" {
      for_each = try(var.dcr.destinations.storage_blob, {})
      content {
        name               = storage_blob.key
        storage_account_id = storage_blob.value.storage_account_id
        container_name     = storage_blob.value.container_name
      }
    }

    dynamic "storage_blob_direct" {
      for_each = try(var.dcr.destinations.storage_blob_direct, {})
      content {
        name               = storage_blob_direct.key
        storage_account_id = storage_blob_direct.value.storage_account_id
        container_name     = storage_blob_direct.value.container_name
      }
    }

    dynamic "storage_table_direct" {
      for_each = try(var.dcr.destinations.storage_table_direct, {})
      content {
        name               = storage_table_direct.key
        storage_account_id = storage_table_direct.value.storage_account_id
        table_name         = storage_table_direct.value.table_name
      }
    }

    dynamic "monitor_account" {
      for_each = try(var.dcr.destinations.monitor_account, {})
      content {
        name               = monitor_account.key
        monitor_account_id = monitor_account.value.monitor_account_id
      }
    }
  }

  dynamic "data_flow" {
    for_each = { for idx, flow in var.dcr.data_flow : idx => flow }
    content {
      streams            = data_flow.value.streams
      destinations       = data_flow.value.destinations
      built_in_transform = try(data_flow.value.built_in_transform, null)
      output_stream      = try(data_flow.value.output_stream, null)
      transform_kql      = try(data_flow.value.transform_kql, null)
    }
  }

  dynamic "data_sources" {
    for_each = try(var.dcr.data_sources, null) != null ? [1] : []
    content {
      dynamic "syslog" {
        for_each = try(var.dcr.data_sources.syslog, {})
        content {
          name           = syslog.key
          facility_names = syslog.value.facility_names
          log_levels     = syslog.value.log_levels
          streams        = syslog.value.streams
        }
      }

      dynamic "windows_event_log" {
        for_each = try(var.dcr.data_sources.windows_event_log, {})
        content {
          name           = windows_event_log.key
          streams        = windows_event_log.value.streams
          x_path_queries = windows_event_log.value.x_path_queries
        }
      }

      dynamic "windows_firewall_log" {
        for_each = try(var.dcr.data_sources.windows_firewall_log, {})
        content {
          name    = windows_firewall_log.key
          streams = windows_firewall_log.value.streams
        }
      }

      dynamic "performance_counter" {
        for_each = try(var.dcr.data_sources.performance_counter, {})
        content {
          name                          = performance_counter.key
          streams                       = performance_counter.value.streams
          sampling_frequency_in_seconds = performance_counter.value.sampling_frequency_in_seconds
          counter_specifiers            = performance_counter.value.counter_specifiers
        }
      }

      dynamic "iis_log" {
        for_each = try(var.dcr.data_sources.iis_log, {})
        content {
          name            = iis_log.key
          streams         = iis_log.value.streams
          log_directories = try(iis_log.value.log_directories, null)
        }
      }

      dynamic "log_file" {
        for_each = try(var.dcr.data_sources.log_file, {})
        content {
          name          = log_file.key
          streams       = log_file.value.streams
          file_patterns = log_file.value.file_patterns
          format        = log_file.value.format

          dynamic "settings" {
            for_each = try(log_file.value.settings, null) != null ? [1] : []
            content {
              text {
                record_start_timestamp_format = log_file.value.settings.text.record_start_timestamp_format
              }
            }
          }
        }
      }

      dynamic "platform_telemetry" {
        for_each = try(var.dcr.data_sources.platform_telemetry, {})
        content {
          name    = platform_telemetry.key
          streams = platform_telemetry.value.streams
        }
      }

      dynamic "prometheus_forwarder" {
        for_each = try(var.dcr.data_sources.prometheus_forwarder, {})
        content {
          name    = prometheus_forwarder.key
          streams = prometheus_forwarder.value.streams

          dynamic "label_include_filter" {
            for_each = try(prometheus_forwarder.value.label_include_filter, {})
            content {
              label = label_include_filter.key
              value = label_include_filter.value
            }
          }
        }
      }

      dynamic "extension" {
        for_each = try(var.dcr.data_sources.extension, {})
        content {
          name               = extension.key
          extension_name     = extension.value.extension_name
          streams            = extension.value.streams
          input_data_sources = try(extension.value.input_data_sources, null)
          extension_json     = try(extension.value.extension_json, null)
        }
      }

      dynamic "data_import" {
        for_each = try(var.dcr.data_sources.data_import, null) != null ? [1] : []
        content {
          event_hub_data_source {
            name           = var.dcr.data_sources.data_import.event_hub_data_source.name
            stream         = var.dcr.data_sources.data_import.event_hub_data_source.stream
            consumer_group = try(var.dcr.data_sources.data_import.event_hub_data_source.consumer_group, null)
          }
        }
      }
    }
  }

  dynamic "stream_declaration" {
    for_each = try(var.dcr.stream_declaration, {})
    content {
      stream_name = stream_declaration.key

      dynamic "column" {
        for_each = stream_declaration.value.column
        content {
          name = column.value.name
          type = column.value.type
        }
      }
    }
  }

  dynamic "identity" {
    for_each = try(var.dcr.identity, null) != null ? [1] : []
    content {
      type         = var.dcr.identity.type
      identity_ids = try(var.dcr.identity.identity_ids, null)
    }
  }

  tags = merge(var.tags, try(var.dcr.tags, {}))
}
