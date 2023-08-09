data "azuread_client_config" "current" {}

module "app" {
  source            = "../../"
  display_name      = var.display_name
  generate_password = true
}
