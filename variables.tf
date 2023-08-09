#------------
# Application
#------------
variable "display_name" {
  type        = string
  description = "The display name for the application."
}

variable "api" {
  description = "An optional api block, which configures API related settings for this application."
  type = object({
    mapped_claims_enabled          = optional(bool, false)
    known_client_applications      = optional(list(string), [])
    requested_access_token_version = optional(number, 1)
    oauth2_permission_scope = optional(list(object({
      admin_consent_description  = string
      admin_consent_display_name = string
      enabled                    = optional(bool, true)
      id                         = string
      type                       = optional(string, "User")
      user_consent_description   = optional(string)
      user_consent_display_name  = optional(string)
      value                      = optional(string)
    })), [])
  })
  default = null
}

variable "app_role" {
  description = "A collection of app_role blocks."
  type        = any
  default     = []
}

variable "device_only_auth_enabled" {
  description = "Specifies whether this application supports device authentication without a user."
  type        = bool
  default     = false
}

variable "fallback_public_client_enabled" {
  description = "Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI."
  type        = bool
  default     = false
}

variable "group_membership_claims" {
  description = "Configures the groups claim issued in a user or OAuth 2.0 access token that the app expects. Possible values are `None`, `SecurityGroup` or `All`."
  type        = list(string)
  default     = ["SecurityGroup"]
}

variable "identifier_uris" {
  description = "A list of user-defined URI(s) that uniquely identify a Web application within it's Azure AD tenant, or within a verified custom domain if the application is multi-tenant."
  type        = list(string)
  default     = []
}

variable "logo_image" {
  description = " A logo image to upload for the application, as a raw base64-encoded string. The image should be in gif, jpeg or png format. Note that once an image has been uploaded, it is not possible to remove it without replacing it with another image."
  type        = string
  default     = null
}

variable "marketing_url" {
  description = "The URL to the application's home page. If no homepage is specified this defaults to `https://{name}`"
  type        = string
  default     = null
}

variable "oauth2_post_response_required" {
  description = "Specifies whether, as part of OAuth 2.0 token requests, Azure AD allows POST requests, as opposed to GET requests."
  type        = bool
  default     = false
}

variable "optional_claims" {
  description = "An optional claim block."
  type        = any
  default     = null
}

variable "owners" {
  description = "A set of object IDs of principals that will be granted ownership of the application. Supported object types are users or service principals."
  type        = list(string)
  default     = []
}

variable "prevent_duplicate_names" {
  description = "If true, will return an error if an existing application is found with the same name."
  type        = bool
  default     = false
}

variable "privacy_statement_url" {
  description = "URL of the application's privacy statement."
  type        = string
  default     = null
}

variable "public_client" {
  description = "To configure non-web app or non-web API application settings, for example mobile or other public clients such as an installed application running on a desktop device. Must be a valid https or ms-appx-web URL."
  type        = any
  default     = null
}

variable "required_resource_access" {
  description = "A collection of required resource access for this application."
  type        = any
  default     = null
}

variable "sign_in_audience" {
  description = "The Microsoft account types that are supported for the current application. Must be one of `AzureADMyOrg`, `AzureADMultipleOrgs`, `AzureADandPersonalMicrosoftAccount` or `PersonalMicrosoftAccount`."
  type        = string
  default     = "AzureADMyOrg"
  validation {
    condition     = contains(["AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount", "PersonalMicrosoftAccount"], var.sign_in_audience)
    error_message = "Valid value is one of the following: AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount or PersonalMicrosoftAccount."
  }
}

variable "single_page_application" {
  description = "A single_page_application block, which configures single-page application (SPA) related settings for this application. Must be https."
  type        = any
  default     = null
}

variable "support_url" {
  description = "URL of the application's support page."
  type        = string
  default     = null
}

variable "tags" {
  description = "A set of tags to apply to the application. Cannot be used together with the feature_tags block"
  type        = list(string)
  default     = []
}

variable "template_id" {
  description = "Unique ID for a templated application in the Azure AD App Gallery, from which to create the application."
  type        = string
  default     = null
}

variable "terms_of_service_url" {
  description = "URL of the application's terms of service statement."
  type        = string
  default     = null
}

variable "web" {
  description = "Configures web related settings for this application."
  type = object({
    homepage_url  = optional(string)
    redirect_uris = optional(list(string))
    logout_url    = optional(string)
    implicit_grant = optional(object({
      access_token_issuance_enabled = optional(bool)
      id_token_issuance_enabled     = optional(bool)
    }))
  })
  default = null
}

#------------
# Application Password
#------------
variable "generate_password" {
  description = "Indicates if want to generate a password for application"
  type        = bool
  default     = false
}

variable "end_date" {
  type        = string
  description = "The end date until which the password is valid, formatted as an RFC3339 date string (e.g. 2018-01-01T01:02:03Z)."
  default     = null
}

variable "end_date_relative" {
  type        = string
  description = "A relative duration for which the password is valid until, for example 240h (10 days) or 2400h30m."
  default     = null
}

variable "rotate_when_changed" {
  type        = map(string)
  description = "A map of arbitrary key/value pairs that will force recreation of the password when they change, enabling password rotation based on external conditions such as a rotating timestamp."
  default     = null
}

variable "start_date" {
  type        = string
  description = "The start date from which the password is valid, formatted as an RFC3339 date string (e.g. 2018-01-01T01:02:03Z). If this isn't specified, the current date is used."
  default     = null
}

#------------
# Service Principal
#------------
variable "create_service_principal" {
  description = "Indicates if want to create a service principal for application."
  type        = bool
  default     = true
}

variable "sp_owners" {
  description = "A set of object IDs of principals that will be granted ownership of both the AAD Application and associated Service Principal. Supported object types are users or service principals."
  type        = list(string)
  default     = []
}

variable "sp_app_role_assignment_required" {
  description = " Whether this service principal requires an app role assignment to a user or group before Azure AD will issue a user or access token to the application."
  type        = bool
  default     = false
}

variable "sp_enterprise_tag" {
  description = "Whether this service principal represents an Enterprise Application. Enabling this will assign the WindowsAzureActiveDirectoryIntegratedApp tag."
  type        = bool
  default     = false
}

#------------
# Web App Authentication
#------------
variable "support_web_app_auth" {
  description = "Set it to true if want use the application to authentication Azure Web App via Active Directory."
  type        = bool
  default     = false
}

variable "web_app_name" {
  description = "The name of the Azure Web App."
  type        = string
  default     = null
}

variable "web_app_homepage" {
  description = "The URL to the application's home page. If no homepage is specified this defaults'"
  type        = string
  default     = null
}

variable "web_app_redirect_uris" {
  description = "A list of URIs that Azure AD should use to redirect users to the application's'"
  type        = list(string)
  default     = []
}

variable "web_app_add_default_redirect_uri" {
  description = "Whether to add the application's default URI to the list of redirect URIs."
  type        = bool
  default     = true
}
