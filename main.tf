module "postgresql-db" {
  source                = "./modules/postgres-sql-module"
  project_name          = local.project_name
  production            = local.environment == "production"
  labels                = local.default_labels
  disk_size             = local.pgsql_disk_size
  vpc_id                = local.vpc_id
  pg_address_space_name = local.postgres_address_name
}

module "redis" {
  source                    = "./redis-cache-module"
  project_name              = local.project_name
  vpc_id                    = local.vpc_id
  redis_reserved_ip_range   = local.redis_reserved_ip_range
  labels                    = local.default_labels
}

module "mongo-atlas" {
  source                         = "./mongo-atlas-database"
  project_name                   = local.project_name
  atlas_org_id                   = local.atlas_org_id
  vpc_network_id                 = local.vpc_id
  vpc_network_name               = local.vpc_name
  atlas_subnet_name              = local.atlas_subnet_name
  atlas_subnet_cidr              = local.mongo_atlas_subnet_cidr
  vpc_cidr_block                 = local.vpc_cidr
  gcp_project_name               = local.gcp_project_name
  gcp_region                     = local.gcp_region
  atlas_gcp_region               = local.gcp_to_atlas_region[local.gcp_region]
  mongodb_version                = local.mongodb_version
  atlas_disk_size                = local.atlas_disk_size
  atlas_instance_type            = local.atlas_instance_type
  atlas_dbuser                   = local.atlas_dbuser
  termination_protection_enabled = local.environment == "production"
  db_audit_enable                = local.environment == "production"
  chosen_copy_region             = local.chosen_copy_region
  labels                         = local.default_labels
}

