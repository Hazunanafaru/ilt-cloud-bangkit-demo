variable "project" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "ilt_name" {
  description = "Name of the ILT session."
  type        = string
}

variable "project_roles" {
  type        = string
  description = "List of roles will be bind to service account separated by ','. e.g 'editor,storage.objectViewer'"
  default     = "editor,storage.objectViewer"
}

variable "prefix" {
  type        = string
  description = "Prefix applied to service account names."
  default     = ""
}

variable "sa_name" {
  type        = string
  description = "Name of the service account. Separated by '-'"
}

variable "sa_display_name" {
  type        = string
  description = "Display name of the service account."
}
