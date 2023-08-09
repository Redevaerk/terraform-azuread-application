resource "random_uuid" "web_app_uuid" {
  count = var.support_web_app_auth ? 1 : 0
}

locals {
  default_web_app_homepage = var.support_web_app_auth ? "https://${var.web_app_name}.azurewebsites.net" : null
  web_app_ad_app_required_resource_access = var.support_web_app_auth ? [{
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
    resource_access = [{
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }]
  }] : null
  web_app_ad_app_api = var.support_web_app_auth ? {
    mapped_claims_enabled          = false
    known_client_applications      = compact(tolist([""]))
    requested_access_token_version = 1
    oauth2_permission_scope = tolist([{
      id                         = tostring(random_uuid.web_app_uuid[0].result)
      enabled                    = true
      type                       = "User"
      value                      = "user_impersonation"
      admin_consent_display_name = "Access ${var.web_app_name}"
      admin_consent_description  = "Allow the application to access ${var.web_app_name} on behalf of the signed-in user."
      user_consent_display_name  = "Access ${var.web_app_name}"
      user_consent_description   = "Allow the application to access ${var.web_app_name} on your behalf."
    }])
  } : null
  web_app_ad_app_web = var.support_web_app_auth ? {
    homepage_url  = var.support_web_app_auth ? coalesce(var.web_app_homepage, local.default_web_app_homepage) : null
    redirect_uris = var.support_web_app_auth ? (var.web_app_add_default_redirect_uri ? compact(concat(["${local.default_web_app_homepage}/.auth/login/aad/callback"], var.web_app_redirect_uris)) : var.web_app_redirect_uris) : []
    logout_url    = null
    implicit_grant = {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  } : null
}

data "azuread_application_published_app_ids" "well_known" {
  count = var.support_web_app_auth ? 1 : 0
  lifecycle {
    precondition {
      condition     = var.create_service_principal
      error_message = "To create Application to support Azure Web App Authentication, it's necessary create service principal. Change `variable.create_service_principal` to true"
    }
  }
}

module "service_principal_msgraph" {
  count          = var.support_web_app_auth ? 1 : 0
  source         = "./modules/service-principal"
  application_id = data.azuread_application_published_app_ids.well_known[0].result.MicrosoftGraph
  use_existing   = true
}

resource "azuread_service_principal_delegated_permission_grant" "web_app_grant" {
  count                                = var.support_web_app_auth ? 1 : 0
  service_principal_object_id          = module.service_principal[0].object_id
  resource_service_principal_object_id = module.service_principal_msgraph[0].object_id
  claim_values                         = ["openid", "profile", "email"]
  lifecycle {
    precondition {
      condition     = var.create_service_principal
      error_message = "To create Application to support Azure Web App Authentication, it's necessary create service principal. Change `variable.create_service_principal` to true"
    }
  }
}
