output "object_id" {
  description = "The object ID of the service principal."
  value       = azuread_service_principal.this.object_id
}
