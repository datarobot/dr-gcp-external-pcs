terraform {
  required_version = ">= 1.5, < 1.9"
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.21"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.9"
    }
  }
}
