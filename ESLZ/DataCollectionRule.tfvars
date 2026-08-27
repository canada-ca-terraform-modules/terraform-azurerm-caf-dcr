data_collection_rules = {
  example = {
    resource_group = "Project" # key in resource_groups map, or full Azure resource ID

    # Optional: Linux, Windows, AgentDirectToStore, WorkspaceTransforms
    # kind = "Linux"

    # Optional: free-form description
    # description = "Collects syslog and performance data from Linux VMs"

    # Optional: resource ID of an azurerm_monitor_data_collection_endpoint
    # data_collection_endpoint_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.Insights/dataCollectionEndpoints/example-dcre"

    # Required: at least one destination must be specified
    destinations = {
      log_analytics = {
        example-destination-log = {
          workspace_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.OperationalInsights/workspaces/example-law"
        }
      }

      # Optional: uncomment to also forward to an Event Hub
      # event_hub = {
      #   example-destination-eventhub = {
      #     event_hub_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.EventHub/namespaces/example-ns/eventhubs/example-eh"
      #   }
      # }

      # Optional: uncomment to also forward to a Storage Blob container
      # storage_blob = {
      #   example-destination-storage = {
      #     storage_account_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.Storage/storageAccounts/examplestorage"
      #     container_name     = "examplecontainer"
      #   }
      # }

      # Optional: uncomment to also forward to Azure Monitor metrics (only for Microsoft-InsightsMetrics streams)
      # azure_monitor_metrics = {
      #   name = "example-destination-metrics"
      # }
    }

    # Required: one or more data flow rules routing streams to destinations
    data_flow = [
      {
        streams      = ["Microsoft-Syslog"]
        destinations = ["example-destination-log"]

        # Optional: KQL transform applied before landing in the destination stream
        # transform_kql = "source | project TimeGenerated, Computer, Message"
      }
    ]

    # Optional: uncomment to configure data sources collected by the Azure Monitor Agent
    # data_sources = {
    #   syslog = {
    #     example-datasource-syslog = {
    #       facility_names = ["*"]
    #       log_levels     = ["*"]
    #       streams        = ["Microsoft-Syslog"]
    #     }
    #   }
    #
    #   performance_counter = {
    #     example-datasource-perfcounter = {
    #       streams                        = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
    #       sampling_frequency_in_seconds  = 60
    #       counter_specifiers             = ["Processor(*)\\% Processor Time"]
    #     }
    #   }
    #
    #   windows_event_log = {
    #     example-datasource-wineventlog = {
    #       streams        = ["Microsoft-WindowsEvent"]
    #       x_path_queries = ["*![System/Level=1]"]
    #     }
    #   }
    # }

    # Optional: uncomment to declare a custom stream schema (used with a Log Analytics transform)
    # stream_declaration = {
    #   Custom-MyTableRawData = {
    #     column = [
    #       { name = "Time", type = "datetime" },
    #       { name = "Computer", type = "string" },
    #     ]
    #   }
    # }

    # Optional: uncomment to assign an identity to the rule
    # identity = {
    #   type         = "SystemAssigned"
    # }

    # Optional: tags merged with the caller's tags
    # tags = {
    #   foo = "bar"
    # }
  }
}
