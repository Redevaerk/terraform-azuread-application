# Terraform AzureAD Application

The Azure AD Application and Service Principal Terraform module streamlines the process of creating and configuring applications within Azure Active Directory (Azure AD)

## Features

1. Azure AD Application Creation: The module automates the creation of applications within Azure AD
2. Service Principal Association: Alongside application creation, the module establishes the necessary association with a service principal.
3. Azure Web App Authentication Integration: The module goes beyond basic application setup by providing specialized support for Azure Web App authentication. It simplifies the integration of your application with Azure Web App authentication mechanisms.

## Usage

```terraform
module "app" {
  source            = "Redevaerk/application/azuread"
  version           = "x.x.x"
  display_name      = var.display_name
  generate_password = true
}
```

## Examples

- [Simple](https://github.com/redevaerk/terraform-azuread-application/tree/main/examples/simple) - This example will create application and generate a secret with default configuration.
- [Build Image With Context](https://github.com/redevaerk/terraform-azuread-application/tree/main/examples/complete) - This example will create application with custom configuration.
- [Web APP Authentication](https://github.com/redevaerk/terraform-azuread-application/tree/main/examples/web-app-auth) - This example create application with default configuration to work with Web Apps.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >2.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >2.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service_principal"></a> [service\_principal](#module\_service\_principal) | ./modules/service-principal | n/a |
| <a name="module_service_principal_msgraph"></a> [service\_principal\_msgraph](#module\_service\_principal\_msgraph) | ./modules/service-principal | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal_delegated_permission_grant.web_app_grant](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_delegated_permission_grant) | resource |
| [random_uuid.web_app_uuid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api"></a> [api](#input\_api) | An optional api block, which configures API related settings for this application. | <pre>object({<br>    mapped_claims_enabled          = optional(bool, false)<br>    known_client_applications      = optional(list(string), [])<br>    requested_access_token_version = optional(number, 1)<br>    oauth2_permission_scope = optional(list(object({<br>      admin_consent_description  = string<br>      admin_consent_display_name = string<br>      enabled                    = optional(bool, true)<br>      id                         = string<br>      type                       = optional(string, "User")<br>      user_consent_description   = optional(string)<br>      user_consent_display_name  = optional(string)<br>      value                      = optional(string)<br>    })), [])<br>  })</pre> | `null` | no |
| <a name="input_app_role"></a> [app\_role](#input\_app\_role) | A collection of app\_role blocks. | `any` | `[]` | no |
| <a name="input_create_service_principal"></a> [create\_service\_principal](#input\_create\_service\_principal) | Indicates if want to create a service principal for application. | `bool` | `true` | no |
| <a name="input_device_only_auth_enabled"></a> [device\_only\_auth\_enabled](#input\_device\_only\_auth\_enabled) | Specifies whether this application supports device authentication without a user. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the application. | `string` | n/a | yes |
| <a name="input_end_date"></a> [end\_date](#input\_end\_date) | The end date until which the password is valid, formatted as an RFC3339 date string (e.g. 2018-01-01T01:02:03Z). | `string` | `null` | no |
| <a name="input_end_date_relative"></a> [end\_date\_relative](#input\_end\_date\_relative) | A relative duration for which the password is valid until, for example 240h (10 days) or 2400h30m. | `string` | `null` | no |
| <a name="input_fallback_public_client_enabled"></a> [fallback\_public\_client\_enabled](#input\_fallback\_public\_client\_enabled) | Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI. | `bool` | `false` | no |
| <a name="input_generate_password"></a> [generate\_password](#input\_generate\_password) | Indicates if want to generate a password for application | `bool` | `false` | no |
| <a name="input_group_membership_claims"></a> [group\_membership\_claims](#input\_group\_membership\_claims) | Configures the groups claim issued in a user or OAuth 2.0 access token that the app expects. Possible values are `None`, `SecurityGroup` or `All`. | `list(string)` | <pre>[<br>  "SecurityGroup"<br>]</pre> | no |
| <a name="input_identifier_uris"></a> [identifier\_uris](#input\_identifier\_uris) | A list of user-defined URI(s) that uniquely identify a Web application within it's Azure AD tenant, or within a verified custom domain if the application is multi-tenant. | `list(string)` | `[]` | no |
| <a name="input_logo_image"></a> [logo\_image](#input\_logo\_image) | A logo image to upload for the application, as a raw base64-encoded string. The image should be in gif, jpeg or png format. Note that once an image has been uploaded, it is not possible to remove it without replacing it with another image. | `string` | `null` | no |
| <a name="input_marketing_url"></a> [marketing\_url](#input\_marketing\_url) | The URL to the application's home page. If no homepage is specified this defaults to `https://{name}` | `string` | `null` | no |
| <a name="input_oauth2_post_response_required"></a> [oauth2\_post\_response\_required](#input\_oauth2\_post\_response\_required) | Specifies whether, as part of OAuth 2.0 token requests, Azure AD allows POST requests, as opposed to GET requests. | `bool` | `false` | no |
| <a name="input_optional_claims"></a> [optional\_claims](#input\_optional\_claims) | An optional claim block. | `any` | `null` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | A set of object IDs of principals that will be granted ownership of the application. Supported object types are users or service principals. | `list(string)` | `[]` | no |
| <a name="input_prevent_duplicate_names"></a> [prevent\_duplicate\_names](#input\_prevent\_duplicate\_names) | If true, will return an error if an existing application is found with the same name. | `bool` | `false` | no |
| <a name="input_privacy_statement_url"></a> [privacy\_statement\_url](#input\_privacy\_statement\_url) | URL of the application's privacy statement. | `string` | `null` | no |
| <a name="input_public_client"></a> [public\_client](#input\_public\_client) | To configure non-web app or non-web API application settings, for example mobile or other public clients such as an installed application running on a desktop device. Must be a valid https or ms-appx-web URL. | `any` | `null` | no |
| <a name="input_required_resource_access"></a> [required\_resource\_access](#input\_required\_resource\_access) | A collection of required resource access for this application. | `any` | `null` | no |
| <a name="input_rotate_when_changed"></a> [rotate\_when\_changed](#input\_rotate\_when\_changed) | A map of arbitrary key/value pairs that will force recreation of the password when they change, enabling password rotation based on external conditions such as a rotating timestamp. | `map(string)` | `null` | no |
| <a name="input_sign_in_audience"></a> [sign\_in\_audience](#input\_sign\_in\_audience) | The Microsoft account types that are supported for the current application. Must be one of `AzureADMyOrg`, `AzureADMultipleOrgs`, `AzureADandPersonalMicrosoftAccount` or `PersonalMicrosoftAccount`. | `string` | `"AzureADMyOrg"` | no |
| <a name="input_single_page_application"></a> [single\_page\_application](#input\_single\_page\_application) | A single\_page\_application block, which configures single-page application (SPA) related settings for this application. Must be https. | `any` | `null` | no |
| <a name="input_sp_app_role_assignment_required"></a> [sp\_app\_role\_assignment\_required](#input\_sp\_app\_role\_assignment\_required) | Whether this service principal requires an app role assignment to a user or group before Azure AD will issue a user or access token to the application. | `bool` | `false` | no |
| <a name="input_sp_enterprise_tag"></a> [sp\_enterprise\_tag](#input\_sp\_enterprise\_tag) | Whether this service principal represents an Enterprise Application. Enabling this will assign the WindowsAzureActiveDirectoryIntegratedApp tag. | `bool` | `false` | no |
| <a name="input_sp_owners"></a> [sp\_owners](#input\_sp\_owners) | A set of object IDs of principals that will be granted ownership of both the AAD Application and associated Service Principal. Supported object types are users or service principals. | `list(string)` | `[]` | no |
| <a name="input_start_date"></a> [start\_date](#input\_start\_date) | The start date from which the password is valid, formatted as an RFC3339 date string (e.g. 2018-01-01T01:02:03Z). If this isn't specified, the current date is used. | `string` | `null` | no |
| <a name="input_support_url"></a> [support\_url](#input\_support\_url) | URL of the application's support page. | `string` | `null` | no |
| <a name="input_support_web_app_auth"></a> [support\_web\_app\_auth](#input\_support\_web\_app\_auth) | Set it to true if want use the application to authentication Azure Web App via Active Directory. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A set of tags to apply to the application. Cannot be used together with the feature\_tags block | `list(string)` | `[]` | no |
| <a name="input_template_id"></a> [template\_id](#input\_template\_id) | Unique ID for a templated application in the Azure AD App Gallery, from which to create the application. | `string` | `null` | no |
| <a name="input_terms_of_service_url"></a> [terms\_of\_service\_url](#input\_terms\_of\_service\_url) | URL of the application's terms of service statement. | `string` | `null` | no |
| <a name="input_web"></a> [web](#input\_web) | Configures web related settings for this application. | <pre>object({<br>    homepage_url  = optional(string)<br>    redirect_uris = optional(list(string))<br>    logout_url    = optional(string)<br>    implicit_grant = optional(object({<br>      access_token_issuance_enabled = optional(bool)<br>      id_token_issuance_enabled     = optional(bool)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_web_app_add_default_redirect_uri"></a> [web\_app\_add\_default\_redirect\_uri](#input\_web\_app\_add\_default\_redirect\_uri) | Whether to add the application's default URI to the list of redirect URIs. | `bool` | `true` | no |
| <a name="input_web_app_homepage"></a> [web\_app\_homepage](#input\_web\_app\_homepage) | The URL to the application's home page. If no homepage is specified this defaults' | `string` | `null` | no |
| <a name="input_web_app_name"></a> [web\_app\_name](#input\_web\_app\_name) | The name of the Azure Web App. | `string` | `null` | no |
| <a name="input_web_app_redirect_uris"></a> [web\_app\_redirect\_uris](#input\_web\_app\_redirect\_uris) | A list of URIs that Azure AD should use to redirect users to the application's' | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_client_secret"></a> [app\_client\_secret](#output\_app\_client\_secret) | App password of AzureAD application created |
| <a name="output_app_role_ids"></a> [app\_role\_ids](#output\_app\_role\_ids) | A mapping of app role values to app role IDs, intended to be useful when referencing app roles in other resources in your configuration. |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The application id of AzureAD application created. |
| <a name="output_disabled_by_microsoft"></a> [disabled\_by\_microsoft](#output\_disabled\_by\_microsoft) | Whether Microsoft has disabled the registered application. If the application is disabled, this will be a string indicating the status/reason, e.g. DisabledDueToViolationOfServicesAgreement. |
| <a name="output_logo_url"></a> [logo\_url](#output\_logo\_url) | CDN URL to the application's logo, as uploaded with the logo\_image property. |
| <a name="output_oauth2_permission_scope_ids"></a> [oauth2\_permission\_scope\_ids](#output\_oauth2\_permission\_scope\_ids) | A mapping of OAuth2.0 permission scope values to scope IDs, intended to be useful when referencing permission scopes in other resources in your configuration. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object id of application. Can be used to assign roles to user. |
| <a name="output_publisher_domain"></a> [publisher\_domain](#output\_publisher\_domain) | The verified publisher domain for the application. |
| <a name="output_sp_object_id"></a> [sp\_object\_id](#output\_sp\_object\_id) | Azure Service Principal Object ID. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/redevaerk/terraform-azuread-application/tree/main/LICENSE) for full details.
