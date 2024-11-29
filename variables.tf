variable "gcp_region" {
  description = "Google Region"
  type        = string
  default     = "us-central1"
}

variable "us_copy_region" {
  type        = list(string)
  default     = ["CENTRAL_US", "EASTERN_US", "US_EAST_4", "US_EAST_5", "NORTH_AMERICA_NORTHEAST_1", "NORTH_AMERICA_NORTHEAST_2", "SOUTH_AMERICA_EAST_1", "SOUTH_AMERICA_WEST_1", "WESTERN_US", "US_WEST_2", "US_WEST_3", "US_WEST_4", "US_SOUTH_1"]
  description = "Region for cross region snapshot store to support major region going down"
}

variable "eu_copy_region" {
  type        = list(string)
  default     = ["WESTERN_EUROPE", "EUROPE_NORTH_1", "EUROPE_WEST_2", "EUROPE_WEST_3", "EUROPE_WEST_4", "EUROPE_WEST_6", "EUROPE_WEST_8", "EUROPE_WEST_9", "EUROPE_WEST_10", "EUROPE_CENTRAL_2", "EUROPE_WEST_12", "EUROPE_SOUTHWEST_1"]
  description = "Region for cross region snapshot store to support major region going down"
}

variable "apac_copy_region" {
  type        = list(string)
  default     = ["EASTERN_ASIA_PACIFIC", "ASIA_EAST_2", "NORTHEASTERN_ASIA_PACIFIC", "ASIA_NORTHEAST_2", "ASIA_NORTHEAST_3", "SOUTHEASTERN_ASIA_PACIFIC", "ASIA_SOUTH_1", "ASIA_SOUTH_2", "AUSTRALIA_SOUTHEAST_1", "AUSTRALIA_SOUTHEAST_2", "ASIA-SOUTHEAST_2"]
  description = "Region for cross region snapshot store to support major region going down"
}

variable "me_copy_region" {
  type        = list(string)
  default     = ["MIDDLE_EAST_WEST_1", "MIDDLE_EAST_CENTRAL_1", "MIDDLE_EAST_CENTRAL_2"]
  description = "Region for cross region snapshot store to support major region going down"
}
