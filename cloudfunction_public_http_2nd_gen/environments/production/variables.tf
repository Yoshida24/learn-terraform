variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "location" {
    description = "Location"
    type        = string
    default     = "us-central1"
}

variable "function_name" {
  description = "Name of CloudFunctions"
  type        = string
  default     = "function-v2"
}
