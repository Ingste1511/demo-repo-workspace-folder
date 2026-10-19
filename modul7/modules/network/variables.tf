variable "name_prefix" {
  description = "Felles navneprefiks for nettverksressursene"
  type        = string
}

variable "location" {
  description = "Azure-region for nettverket"
  type        = string
}

variable "resource_group_name" {
  description = "Navnet på resource group nettverket skal ligge i"
  type        = string
}