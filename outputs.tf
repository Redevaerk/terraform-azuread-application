#------------
# Application
#------------
output "object_id" {
  description = "The object id of application. Can be used to assign roles to user."
  value       = azuread_application.this.object_id
}

output "client_id" {
  description = "The application id of AzureAD application created."
  value       = azuread_application.this.application_id
}

output "logo_url" {
  description = "CDN URL to the application's logo, as uploaded with the logo_image property."
  value       = azuread_application.this.logo_url
}

output "disabled_by_microsoft" {
  description = "Whether Microsoft has disabled the registered application. If the application is disabled, this will be a string indicating the status/reason, e.g. DisabledDueToViolationOfServicesAgreement."
  value       = azuread_application.this.disabled_by_microsoft
}

output "publisher_domain" {
  description = "The verified publisher domain for the application."
  value       = azuread_application.this.publisher_domain
}

output "oauth2_permission_scope_ids" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs, intended to be useful when referencing permission scopes in other resources in your configuration."
  value       = azuread_application.this.oauth2_permission_scope_ids
}

output "app_role_ids" {
  description = "A mapping of app role values to app role IDs, intended to be useful when referencing app roles in other resources in your configuration."
  value       = azuread_application.this.app_role_ids
}

output "app_client_secret" {
  description = "App password of AzureAD application created"
  value       = local.generate_password ? azuread_application_password.this[0].value : null
}

#------------
# Service Principal
#------------
output "sp_object_id" {
  description = "Azure Service Principal Object ID."
  value       = var.create_service_principal ? module.service_principal[0].object_id : null
}
