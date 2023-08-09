output "object_id" {
  description = "The object id of application. Can be used to assign roles to user."
  value       = module.app.object_id
}

output "application_id" {
  description = "The application id of AzureAD application created."
  value       = module.app.client_id
}

output "logo_url" {
  description = "CDN URL to the application's logo, as uploaded with the logo_image property."
  value       = module.app.logo_url
}

output "disabled_by_microsoft" {
  description = "Whether Microsoft has disabled the registered application. If the application is disabled, this will be a string indicating the status/reason, e.g. DisabledDueToViolationOfServicesAgreement."
  value       = module.app.disabled_by_microsoft
}

output "publisher_domain" {
  description = "The verified publisher domain for the application."
  value       = module.app.publisher_domain
}
