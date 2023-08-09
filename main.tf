locals {
  required_resource_access = var.support_web_app_auth ? concat(local.web_app_ad_app_required_resource_access, coalesce(var.required_resource_access, [])) : var.required_resource_access
  api                      = var.support_web_app_auth ? local.web_app_ad_app_api : var.api
  web                      = var.support_web_app_auth ? local.web_app_ad_app_web : var.web
  generate_password        = var.support_web_app_auth ? true : var.generate_password
}

resource "azuread_application" "this" {
  display_name                   = var.display_name
  device_only_auth_enabled       = var.device_only_auth_enabled
  fallback_public_client_enabled = var.fallback_public_client_enabled
  group_membership_claims        = var.group_membership_claims
  identifier_uris                = var.identifier_uris
  marketing_url                  = var.marketing_url
  oauth2_post_response_required  = var.oauth2_post_response_required
  owners                         = var.owners
  prevent_duplicate_names        = var.prevent_duplicate_names
  privacy_statement_url          = var.privacy_statement_url
  template_id                    = var.template_id
  terms_of_service_url           = var.terms_of_service_url
  logo_image                     = var.logo_image
  sign_in_audience               = var.sign_in_audience
  support_url                    = var.support_url
  tags                           = var.tags

  dynamic "optional_claims" {
    for_each = var.optional_claims != null ? ["true"] : []
    content {

      dynamic "access_token" {
        for_each = lookup(var.optional_claims, "access_token", [])
        content {
          additional_properties = lookup(var.optional_claims.access_token, "additional_properties", [])
          essential             = lookup(var.optional_claims.access_token, "essential", null)
          name                  = lookup(var.optional_claims.access_token, "name", [])
          source                = lookup(var.optional_claims.access_token, "source", null)
        }
      }

      dynamic "id_token" {
        for_each = lookup(var.optional_claims, "id_token", [])
        content {
          additional_properties = lookup(var.optional_claims.id_token, "additional_properties", null)
          essential             = lookup(var.optional_claims.id_token, "essential", null)
          name                  = lookup(var.optional_claims.id_token, "name", null)
          source                = lookup(var.optional_claims.id_token, "source", null)
        }
      }

      dynamic "saml2_token" {
        for_each = lookup(var.optional_claims, "saml2_token", [])
        content {
          additional_properties = lookup(var.optional_claims.saml2_token, "additional_properties", null)
          essential             = lookup(var.optional_claims.saml2_token, "essential", null)
          name                  = lookup(var.optional_claims.saml2_token, "name", null)
          source                = lookup(var.optional_claims.saml2_token, "source", null)
        }
      }
    }
  }

  dynamic "public_client" {
    for_each = var.public_client != null ? ["true"] : []
    content {
      redirect_uris = lookup(var.public_client, "redirect_uris", null)
    }
  }

  dynamic "single_page_application" {
    for_each = var.single_page_application != null ? ["true"] : []
    content {
      redirect_uris = lookup(var.single_page_application, "redirect_uris", null)
    }
  }

  dynamic "api" {
    for_each = local.api != null ? ["true"] : []
    content {
      mapped_claims_enabled          = lookup(local.api, "mapped_claims_enabled", null)
      requested_access_token_version = lookup(local.api, "requested_access_token_version", null)
      known_client_applications      = lookup(local.api, "known_client_applications", null)

      dynamic "oauth2_permission_scope" {
        for_each = lookup(local.api, "oauth2_permission_scope", [])
        content {
          admin_consent_description  = oauth2_permission_scope.value["admin_consent_description"]
          admin_consent_display_name = oauth2_permission_scope.value["admin_consent_display_name"]
          id                         = oauth2_permission_scope.value["id"]
          enabled                    = lookup(oauth2_permission_scope.value, "enabled", true)
          type                       = oauth2_permission_scope.value["type"]
          user_consent_description   = lookup(oauth2_permission_scope.value, "user_consent_description", null)
          user_consent_display_name  = lookup(oauth2_permission_scope.value, "user_consent_display_name", null)
          value                      = lookup(oauth2_permission_scope.value, "value", null)
        }
      }
    }
  }

  dynamic "web" {
    for_each = local.web != null ? ["true"] : []
    content {
      redirect_uris = lookup(local.web, "redirect_uris", null)
      homepage_url  = lookup(local.web, "homepage_url", null)
      logout_url    = lookup(local.web, "logout_url", null)

      dynamic "implicit_grant" {
        for_each = lookup(local.web, "implicit_grant", null) != null ? [1] : []
        content {
          access_token_issuance_enabled = lookup(local.web.implicit_grant, "access_token_issuance_enabled", null)
          id_token_issuance_enabled     = lookup(local.web.implicit_grant, "id_token_issuance_enabled", null)
        }
      }
    }
  }

  dynamic "app_role" {
    for_each = var.app_role != null ? var.app_role : []
    content {
      allowed_member_types = app_role.value.allowed_member_types
      description          = app_role.value.description
      display_name         = app_role.value.display_name
      enabled              = lookup(app_role.value, "enabled", true)
      id                   = app_role.value.id
      value                = lookup(app_role.value, "value", null)
    }
  }

  dynamic "required_resource_access" {
    for_each = local.required_resource_access != null ? local.required_resource_access : []

    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access
        iterator = access
        content {
          id   = access.value.id
          type = access.value.type
        }
      }
    }
  }
}

resource "azuread_application_password" "this" {
  count                 = local.generate_password ? 1 : 0
  application_object_id = azuread_application.this.object_id
  display_name          = var.display_name
  end_date              = var.end_date
  end_date_relative     = var.end_date_relative
  rotate_when_changed   = var.rotate_when_changed
  start_date            = var.start_date
}

module "service_principal" {
  count                        = var.create_service_principal ? 1 : 0
  source                       = "./modules/service-principal"
  application_id               = azuread_application.this.application_id
  owners                       = var.sp_owners
  app_role_assignment_required = var.sp_app_role_assignment_required
  enterprise_tag               = var.sp_enterprise_tag
}
