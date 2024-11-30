variable "labels" {
  description = "Labels to Apply"
  type        = map(string)
}

variable "project_name" {
  description = "Customer Name"
  type        = string
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

variable "vpc_network_id" {
  description = "VPC Network ID"
  type        = string
}

variable "redis_reserved_ip_range" {
  description = "Reserved address space used for the Redis private network service"
}

variable "redis_subnet_cidr" {
  description = "Redis CIDR Range"
  type        = string
}

