locals {
  dcr_regex                             = "/[^0-9a-z]/"
  env-regex_compliant_4                 = replace(lower(substr(var.env, 0, 4)), local.dcr_regex, "")
  group-regex_compliant                 = replace(lower(var.group), local.dcr_regex, "")
  project-regex_compliant               = replace(lower(var.project), local.dcr_regex, "")
  dcr-userDefinedString-regex_compliant = replace(lower(var.userDefinedString), local.dcr_regex, "")
  dcr_prefix                            = "${local.env-regex_compliant_4}-${local.group-regex_compliant}-${local.project-regex_compliant}"
  dcr_name                              = substr("${local.dcr_prefix}-${local.dcr-userDefinedString-regex_compliant}", 0, 64)
}
