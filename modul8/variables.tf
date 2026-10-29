variable "student_id" {
  description = "ingste1"
  type        = string
  # Ingen default – dette MÅ settes bevisst av hver enkelt student

  validation {
    condition     = can(regex("^[a-z0-9]{3,8}$", var.student_id))
    error_message = "student_id må være 3-8 tegn og kun inneholde små bokstaver og tall."
  }
}

variable "project" {
  description = "Kort prosjektnavn brukt i ressursnavn"
  type        = string
  default     = "iac"

  validation {
    condition     = length(var.project) <= 10
    error_message = "Prosjektnavnet kan ikke være lengre enn 10 tegn."
  }
}

variable "location" {
  description = "Azure-region for ressursene"
  type        = string
  default     = "norwayeast" # eller overstyr i terraform.tfvars
}