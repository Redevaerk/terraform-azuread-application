module "app" {
  source               = "../../"
  display_name         = var.display_name
  web_app_name         = var.web_app_name
  support_web_app_auth = true
  generate_password    = true

}
