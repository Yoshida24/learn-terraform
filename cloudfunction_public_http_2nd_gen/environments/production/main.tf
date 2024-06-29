terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.34.0"
    }
  }
}

module "cloudfunction" {
  source = "../../modules/public_http_function"
  function_name = var.function_name
  project_id = var.project_id
  location = var.location
}
