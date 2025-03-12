terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.24.0"
    }
  }

  backend "gcs" {
    bucket = "tsm-terraform-prod"
    prefix = "terraform"
  }
}


provider "google" {
  project = var.project
  region  = var.region
}

module "common" {
  source = "../../modules/common"
  bucket-name = "tsm-sykmelding-xml-prod"
}
