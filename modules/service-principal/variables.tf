variable "application_id" {
  description = "The application ID (client ID) of the application for which to create a service principal."
  type        = string
}

variable "owners" {
  description = "A set of object IDs of principals that will be granted ownership of both the AAD Application and associated Service Principal. Supported object types are users or service principals."
  type        = list(string)
  default     = []
}

variable "app_role_assignment_required" {
  description = " Whether this service principal requires an app role assignment to a user or group before Azure AD will issue a user or access token to the application."
  type        = bool
  default     = false
}

variable "enterprise_tag" {
  description = "Whether this service principal represents an Enterprise Application. Enabling this will assign the WindowsAzureActiveDirectoryIntegratedApp tag."
  type        = bool
  default     = false
}

variable "use_existing" {
  description = "When true, any existing service principal linked to the same application will be automatically imported. When false, an import error will be raised for any pre-existing service principal."
  type        = bool
  default     = false
}
