output "application_id" {
  description = "The application id of AzureAD application created."
  value       = module.app.client_id
}

output "tenant_id" {
  description = "The tenant id of AzureAD application created."
  value       = data.azuread_client_config.current.tenant_id
}
