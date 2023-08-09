locals {
  have_feature_tags = var.enterprise_tag ? true : false
}

resource "azuread_service_principal" "this" {
  application_id               = var.application_id
  app_role_assignment_required = var.app_role_assignment_required
  owners                       = var.owners
  use_existing                 = var.use_existing
  dynamic "feature_tags" {
    for_each = local.have_feature_tags ? ["enabled"] : []
    content {
      enterprise = var.enterprise_tag
    }
  }
}
