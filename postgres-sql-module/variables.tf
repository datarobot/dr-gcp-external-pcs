variable "disk_size" {
  type        = number
  description = "disk size in GBs"
  default     = 20
}

variable "vpc_id" {
  description = "VPC ID"
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

variable "address_space_name" {
  description = "Name of reserved address space used for the PostgreSQL private network service"
}
