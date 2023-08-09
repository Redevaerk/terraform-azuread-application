variable "display_name" {
  type        = string
  description = "The display name for the application."
}

variable "web_app_name" {
  description = "The name of the Azure Web App."
  type        = string
  default     = null
}
