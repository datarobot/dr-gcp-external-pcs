variable "gcp_project_name" {
  description = "GCP Project ID"
  type        = string
}

variable "atlas_gcp_region" {
  description = "atlas gcp region"
  type        = string
}

variable "gcp_region" {
  description = "gcp region"
  type        = string
}

variable "atlas_org_id" {
  description = "atlas datarobot organization id"
  type        = string
}

variable "mongodb_version" {
  type = string
}

variable "atlas_disk_size" {
  description = "atlas disk size"
  #  default     = "20"
  type = string
}

variable "atlas_instance_type" {
  description = "atlas instance type"
  type        = string
  default     = "M40"
}

variable "atlas_dbuser" {
  description = "atlas datarobot user"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR"
  type        = string
}

variable "vpc_network_id" {
  description = "VPC Network ID"
  type        = string
}

variable "vpc_network_name" {
  description = "VPC Network Name"
  type        = string
}

variable "project_name" {
  description = "Customer Name"
  type        = string
}

variable "atlas_subnet_name" {
  description = "Atlas subnet name"
  type        = string
}

variable "atlas_subnet_cidr" {
  description = "Atlas subnet CIDR block"
  type        = string
}

variable "termination_protection_enabled" {
  description = "Enable protection to avoid accidental production cluster termination"
  type        = bool
}

variable "chosen_copy_region" {
  type        = string
  description = "get current region cluster is provisioned"

  validation {
    condition     = var.chosen_copy_region != null
    error_message = "chosen_copy_region must be set to a valid region, add a region if it does not exist"
  }
}
