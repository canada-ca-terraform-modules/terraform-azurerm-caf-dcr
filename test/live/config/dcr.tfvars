# config/dcr.tfvars
# Tracked, ready-to-run fixture for the test/live harness - one representative
# real-usage instance, not a two-code-path engineered fixture and not a
# dormant "_" template.
#
# Exercises the Log Analytics destination + syslog data source + data_flow
# path.
#
# Maintained by whoever adds a new optional input to the module: update this
# file in the same PR if you want live coverage of it, same discipline as
# updating tests/dcr.tftest.hcl.

env               = "livetest"
group             = "caf"
project           = "dcr"
userDefinedString = "livetest"

dcr = {
  resource_group = "live_test" # key from local.resource_groups (test_dependencies.tf)
  kind           = "Linux"
  description    = "live-test Data Collection Rule"

  destinations = {
    log_analytics = {
      live-test-law = {
        # Real value injected in main.tf from test_dependencies.tf's
        # azurerm_log_analytics_workspace.live_test - not known until apply
        # time, so it can't live in this static fixture.
        workspace_resource_id = null
      }
    }
  }

  data_flow = [
    {
      streams      = ["Microsoft-Syslog"]
      destinations = ["live-test-law"]
    }
  ]

  data_sources = {
    syslog = {
      live-test-syslog = {
        facility_names = ["*"]
        log_levels     = ["*"]
        streams        = ["Microsoft-Syslog"]
      }
    }
  }
}
