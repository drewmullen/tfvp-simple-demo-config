locals {
  files = fileset("${path.module}/apps", "*.json")
  apps = { for f in local.files : trim(f, ".json") => jsondecode(file("${path.module}/apps/${f}")) }
}

resource "vault_identity_group" "apps" {
  for_each = local.apps
  name     = each.value.app_id 
  type     = "internal"
  metadata = {
    description = each.value.description
  }
}