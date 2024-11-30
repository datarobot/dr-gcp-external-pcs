locals {

  default_labels = {
    customer    = "datarobot"
    user        = "datarobot"
    cost-center = "org-cost-center"
    cluster_id  = "datarobot-k8s-cluster-association"
    environment = "development"
    expiration  = "never"
  }
  # Atlas
  gcp_project_name               = "datarobot-ext-pcs"
  atlas_org_id                   = ""
  mongodb_version                = "6.0"
  atlas_disk_size                = 50
  atlas_instance_type            = "M40"
  atlas_dbuser                   = "pcs-mongodb"
  vpc_cidr_block                 = "10.8.0.0/16"
  vpc_network_id                 = "projects/mytest-project-us-east1/global/networks/mytest-vpc-network"
  vpc_network_name               = "myorg-test-gcp-vpc"
  project_name                   = "my-existing-gcp-project"
  atlas_subnet_name              = "my-test-gcp-mongo-atlas"
  mongo_atlas_subnet_cidr        = "10.8.7.0/24"
  termination_protection_enabled = true

  #postgres
  pgsql_disk_size      = 50
  vpc_id               = "projects/mytest-project-us-east1/global/networks/mytest-vpc-network"
  environment          = "dev"
  postgres_subnet_cidr = "10.8.6.0/24"

  #redis
  memory_size_gb    = 8
  redis_subnet_cidr = "10.8.5.0/24"

  current_region_type = local.gcp_to_atlas_region[var.gcp_region]
  is_us_region        = length([for region in var.us_copy_region : region if region == local.current_region_type]) > 0
  is_eu_region        = length([for region in var.eu_copy_region : region if region == local.current_region_type]) > 0
  is_apac_region      = length([for region in var.apac_copy_region : region if region == local.current_region_type]) > 0
  is_me_region        = length([for region in var.me_copy_region : region if region == local.current_region_type]) > 0

  chosen_copy_region = local.is_us_region ? element([for region in var.us_copy_region : region if region != local.current_region_type], 0) : local.is_eu_region ? element([for region in var.eu_copy_region : region if region != local.current_region_type], 0) : local.is_apac_region ? element([for region in var.apac_copy_region : region if region != local.current_region_type], 0) : local.is_me_region ? element([for region in var.me_copy_region : region if region != local.current_region_type], 0) : null

  gcp_to_atlas_region = {
    #US Regions
    "us-central1"             = "CENTRAL_US"
    "us-east1"                = "EASTERN_US"
    "us-east4"                = "US_EAST_4"
    "us-east5"                = "US_EAST_5"
    "northamerica-northeast1" = "NORTH_AMERICA_NORTHEAST_1"
    "northamerica-northeast2" = "NORTH_AMERICA_NORTHEAST_2"
    "southamerica-east1"      = "SOUTH_AMERICA_EAST_1"
    "southamerica-west1"      = "SOUTH_AMERICA_WEST_1"
    "us-west1"                = "WESTERN_US"
    "us-west2"                = "US_WEST_2"
    "us-west3"                = "US_WEST_3"
    "us-west4"                = "US_WEST_4"
    "us-south1"               = "US_SOUTH_1"
    #EU Regions
    "europe-west1"      = "WESTERN_EUROPE"
    "europe-north1"     = "EUROPE_NORTH_1"
    "europe-west2"      = "EUROPE_WEST_2"
    "europe-west3"      = "EUROPE_WEST_3"
    "europe-west4"      = "EUROPE_WEST_4"
    "europe-west6"      = "EUROPE_WEST_6"
    "europe-west10"     = "EUROPE_WEST_10"
    "europe-central2"   = "EUROPE_CENTRAL_2"
    "europe-west8"      = "EUROPE_WEST_8"
    "europe-west9"      = "EUROPE_WEST_9"
    "europe-west12"     = "EUROPE_WEST_12"
    "europe-southwest1" = "EUROPE_SOUTHWEST_1"
    #APAC Regions
    "asia-east1"           = "EASTERN_ASIA_PACIFIC"
    "asia-east2"           = "ASIA_EAST_2"
    "asia-northeast1"      = "NORTHEASTERN_ASIA_PACIFIC"
    "asia-northeast2"      = "ASIA_NORTHEAST_2"
    "asia-northeast3"      = "ASIA_NORTHEAST_3"
    "asia-southeast1"      = "SOUTHEASTERN_ASIA_PACIFIC"
    "asia-south1"          = "ASIA_SOUTH_1"
    "asia-south2"          = "ASIA_SOUTH_2"
    "australia-southeast1" = "AUSTRALIA_SOUTHEAST_1"
    "australia-southeast2" = "AUSTRALIA_SOUTHEAST_2"
    "asia-southeast2"      = "ASIA-SOUTHEAST_2"
    #Middle East Regions
    "me-west1"    = "MIDDLE_EAST_WEST_1"
    "me-central1" = "MIDDLE_EAST_CENTRAL_1"
    "me-central2" = "MIDDLE_EAST_CENTRAL_2"
  }
}

variable "atlas_public_key" {}
variable "atlas_private_key" {}
