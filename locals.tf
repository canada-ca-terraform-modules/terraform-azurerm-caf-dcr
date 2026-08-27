locals {
  # Parses the resource group name. If the module received an ID (contains /resourceGroups/) then gets the name after the last /
  # If not, then fetch the resource group name with the resource group object that was also passed
  resource_group_name = strcontains(var.dcr.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.dcr.resource_group) : var.resource_groups[var.dcr.resource_group].name
}
