terraform {
  required_version = ">= 1.0"
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.11"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.5"
    }
  }
}
