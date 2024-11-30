variable "labels" {
  description = "Labels to Apply"
  type        = map(string)
}

variable "disk_size" {
  type        = number
  description = "disk size in GBs"
  default     = 20
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_network_id" {
  description = "VPC Network ID"
  type        = string
}

variable "project_name" {
  description = "Customer Name"
  type        = string
}

variable "production" {
  description = "True if this is a production cluster"
  type        = bool
}

variable "postgres_subnet_cidr" {
  description = "Postgres CIDR Range"
  type        = string
}

