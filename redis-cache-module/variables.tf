variable "project_name" {
  description = "Customer Name"
  type        = string
}

variable "labels" {
  description = "Labels to Apply"
  type        = map(string)
}

variable "memory_size_gb" {
  type        = number
  description = "GBs of ram for redis"
  default     = 8
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "address_space_name" {
  description = "Name of reserved address space used for the Redis private network service"
}
