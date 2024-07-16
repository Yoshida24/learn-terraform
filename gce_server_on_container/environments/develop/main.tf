terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.34.0"
    }
  }
}

module "server" {
  source = "../../modules/server"
  project_id = var.project_id
  location = var.location
  zone = var.zone
  container_image = var.container_image
}
