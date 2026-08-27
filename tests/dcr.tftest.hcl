mock_provider "azurerm" {}

variables {
  env               = "Dev"
  group             = "SLRD"
  project           = "test"
  userDefinedString = "rule"
  location          = "canadacentral"
  resource_groups = {
    Project = { name = "rg-proj", id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj" }
  }
  tags = { environment = "dev" }
}

# ─── naming_convention ──────────────────────────────────────────────────────
run "naming_convention" {
  command = plan

  variables {
    dcr = {
      resource_group = "Project"
      destinations = {
        log_analytics = {
          example-destination-log = {
            workspace_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.OperationalInsights/workspaces/example-law"
          }
        }
      }
      data_flow = [
        {
          streams      = ["Microsoft-Syslog"]
          destinations = ["example-destination-log"]
        }
      ]
    }
  }

  assert {
    condition     = azurerm_monitor_data_collection_rule.dcr.name == "dev-slrd-test-rule"
    error_message = "Name must follow {env4}-{group}-{project}-{userDefinedString} convention"
  }
}

# ─── default_values ─────────────────────────────────────────────────────────
run "default_values" {
  command = plan

  variables {
    dcr = {
      resource_group = "Project"
      destinations = {
        log_analytics = {
          example-destination-log = {
            workspace_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.OperationalInsights/workspaces/example-law"
          }
        }
      }
      data_flow = [
        {
          streams      = ["Microsoft-Syslog"]
          destinations = ["example-destination-log"]
        }
      ]
    }
  }

  assert {
    condition     = azurerm_monitor_data_collection_rule.dcr.location == "canadacentral"
    error_message = "Default location must apply when not overridden"
  }
}

# ─── multiple_destinations_and_data_flow ────────────────────────────────────
run "multiple_destinations_and_data_flow" {
  command = plan

  variables {
    dcr = {
      resource_group = "Project"
      kind           = "Linux"
      destinations = {
        log_analytics = {
          example-destination-log = {
            workspace_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.OperationalInsights/workspaces/example-law"
          }
        }
        event_hub = {
          example-destination-eventhub = {
            event_hub_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.EventHub/namespaces/example-ns/eventhubs/example-eh"
          }
        }
      }
      data_flow = [
        {
          streams      = ["Microsoft-Syslog"]
          destinations = ["example-destination-log"]
        },
        {
          streams      = ["Microsoft-Syslog"]
          destinations = ["example-destination-eventhub"]
        }
      ]
    }
  }

  assert {
    condition     = length(azurerm_monitor_data_collection_rule.dcr.data_flow) == 2
    error_message = "Both data_flow entries must be present"
  }
}

# ─── data_sources_and_stream_declaration ────────────────────────────────────
run "data_sources_and_stream_declaration" {
  command = plan

  variables {
    dcr = {
      resource_group = "Project"
      destinations = {
        log_analytics = {
          example-destination-log = {
            workspace_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.OperationalInsights/workspaces/example-law"
          }
        }
      }
      data_flow = [
        {
          streams       = ["Custom-MyTableRawData"]
          destinations  = ["example-destination-log"]
          output_stream = "Microsoft-Syslog"
          transform_kql = "source | project TimeGenerated = Time, Computer, Message = AdditionalContext"
        }
      ]
      data_sources = {
        syslog = {
          example-datasource-syslog = {
            facility_names = ["*"]
            log_levels     = ["*"]
            streams        = ["Microsoft-Syslog"]
          }
        }
      }
      stream_declaration = {
        Custom-MyTableRawData = {
          column = [
            { name = "Time", type = "datetime" },
            { name = "Computer", type = "string" },
            { name = "AdditionalContext", type = "string" },
          ]
        }
      }
    }
  }

  assert {
    condition     = azurerm_monitor_data_collection_rule.dcr.data_sources[0].syslog[0].name == "example-datasource-syslog"
    error_message = "syslog data source must be configured"
  }
}

# ─── identity ────────────────────────────────────────────────────────────────
run "identity" {
  command = plan

  variables {
    dcr = {
      resource_group = "Project"
      destinations = {
        log_analytics = {
          example-destination-log = {
            workspace_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-proj/providers/Microsoft.OperationalInsights/workspaces/example-law"
          }
        }
      }
      data_flow = [
        {
          streams      = ["Microsoft-Syslog"]
          destinations = ["example-destination-log"]
        }
      ]
      identity = {
        type = "SystemAssigned"
      }
    }
  }

  assert {
    condition     = azurerm_monitor_data_collection_rule.dcr.identity[0].type == "SystemAssigned"
    error_message = "identity block must be configured"
  }
}
