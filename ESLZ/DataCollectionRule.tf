variable "data_collection_rules" {
  description = "Data Collection Rules to deploy"
  type        = any
  default     = {}
}

module "dcr" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-dcr.git?ref=v1.0.0"
  for_each = var.data_collection_rules

  userDefinedString = each.key
  env               = var.env
  group             = var.group
  project           = var.project
  location          = var.location
  resource_groups   = local.resource_groups_all
  dcr               = each.value
  tags              = var.tags
}
