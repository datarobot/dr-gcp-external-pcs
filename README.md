## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mongo-atlas"></a> [mongo-atlas](#module\_mongo-atlas) | ./mongo-atlas-database | n/a |
| <a name="module_postgresql-db"></a> [postgresql-db](#module\_postgresql-db) | ./postgres-sql-module | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | ./redis-cache-module | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apac_copy_region"></a> [apac\_copy\_region](#input\_apac\_copy\_region) | Region for cross region snapshot store to support major region going down | `list(string)` | <pre>[<br>  "EASTERN_ASIA_PACIFIC",<br>  "ASIA_EAST_2",<br>  "NORTHEASTERN_ASIA_PACIFIC",<br>  "ASIA_NORTHEAST_2",<br>  "ASIA_NORTHEAST_3",<br>  "SOUTHEASTERN_ASIA_PACIFIC",<br>  "ASIA_SOUTH_1",<br>  "ASIA_SOUTH_2",<br>  "AUSTRALIA_SOUTHEAST_1",<br>  "AUSTRALIA_SOUTHEAST_2",<br>  "ASIA-SOUTHEAST_2"<br>]</pre> | no |
| <a name="input_atlas_private_key"></a> [atlas\_private\_key](#input\_atlas\_private\_key) | n/a | `any` | n/a | yes |
| <a name="input_atlas_public_key"></a> [atlas\_public\_key](#input\_atlas\_public\_key) | n/a | `any` | n/a | yes |
| <a name="input_eu_copy_region"></a> [eu\_copy\_region](#input\_eu\_copy\_region) | Region for cross region snapshot store to support major region going down | `list(string)` | <pre>[<br>  "WESTERN_EUROPE",<br>  "EUROPE_NORTH_1",<br>  "EUROPE_WEST_2",<br>  "EUROPE_WEST_3",<br>  "EUROPE_WEST_4",<br>  "EUROPE_WEST_6",<br>  "EUROPE_WEST_8",<br>  "EUROPE_WEST_9",<br>  "EUROPE_WEST_10",<br>  "EUROPE_CENTRAL_2",<br>  "EUROPE_WEST_12",<br>  "EUROPE_SOUTHWEST_1"<br>]</pre> | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | Google Region | `string` | `"us-central1"` | no |
| <a name="input_me_copy_region"></a> [me\_copy\_region](#input\_me\_copy\_region) | Region for cross region snapshot store to support major region going down | `list(string)` | <pre>[<br>  "MIDDLE_EAST_WEST_1",<br>  "MIDDLE_EAST_CENTRAL_1",<br>  "MIDDLE_EAST_CENTRAL_2"<br>]</pre> | no |
| <a name="input_us_copy_region"></a> [us\_copy\_region](#input\_us\_copy\_region) | Region for cross region snapshot store to support major region going down | `list(string)` | <pre>[<br>  "CENTRAL_US",<br>  "EASTERN_US",<br>  "US_EAST_4",<br>  "US_EAST_5",<br>  "NORTH_AMERICA_NORTHEAST_1",<br>  "NORTH_AMERICA_NORTHEAST_2",<br>  "SOUTH_AMERICA_EAST_1",<br>  "SOUTH_AMERICA_WEST_1",<br>  "WESTERN_US",<br>  "US_WEST_2",<br>  "US_WEST_3",<br>  "US_WEST_4",<br>  "US_SOUTH_1"<br>]</pre> | no |

## Outputs

No outputs.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.9 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | ~> 1.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 5.9 |
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | ~> 1.21 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.ips_allocated_atlas_pl](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_forwarding_rule.compute_address_rule_mapping_atlas_pl](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule) | resource |
| [google_secret_manager_secret.atlas_dbpass](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.atlas_dbpass](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [mongodbatlas_advanced_cluster.cluster](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster) | resource |
| [mongodbatlas_cloud_backup_schedule.default](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cloud_backup_schedule) | resource |
| [mongodbatlas_database_user.db-user](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/database_user) | resource |
| [mongodbatlas_privatelink_endpoint.gcp_atlas_pl](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint) | resource |
| [mongodbatlas_privatelink_endpoint_service.atlas](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint_service) | resource |
| [mongodbatlas_project.gcp_atlas](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project) | resource |
| [mongodbatlas_project_ip_access_list.cidr_whitelist](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project_ip_access_list) | resource |
| [random_password.password_atlas](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atlas_dbuser"></a> [atlas\_dbuser](#input\_atlas\_dbuser) | atlas datarobot user | `string` | n/a | yes |
| <a name="input_atlas_disk_size"></a> [atlas\_disk\_size](#input\_atlas\_disk\_size) | atlas disk size | `string` | n/a | yes |
| <a name="input_atlas_gcp_region"></a> [atlas\_gcp\_region](#input\_atlas\_gcp\_region) | atlas gcp region | `string` | n/a | yes |
| <a name="input_atlas_instance_type"></a> [atlas\_instance\_type](#input\_atlas\_instance\_type) | atlas instance type | `string` | `"M40"` | no |
| <a name="input_atlas_org_id"></a> [atlas\_org\_id](#input\_atlas\_org\_id) | atlas datarobot organization id | `string` | n/a | yes |
| <a name="input_atlas_subnet_cidr"></a> [atlas\_subnet\_cidr](#input\_atlas\_subnet\_cidr) | Atlas subnet CIDR block | `string` | n/a | yes |
| <a name="input_atlas_subnet_name"></a> [atlas\_subnet\_name](#input\_atlas\_subnet\_name) | Atlas subnet name | `string` | n/a | yes |
| <a name="input_chosen_copy_region"></a> [chosen\_copy\_region](#input\_chosen\_copy\_region) | Get current region cluster is provisioned | `string` | n/a | yes |
| <a name="input_gcp_project_name"></a> [gcp\_project\_name](#input\_gcp\_project\_name) | GCP Project ID | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | gcp region | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to Apply | `map(string)` | n/a | yes |
| <a name="input_mongodb_version"></a> [mongodb\_version](#input\_mongodb\_version) | n/a | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Customer Name | `string` | n/a | yes |
| <a name="input_termination_protection_enabled"></a> [termination\_protection\_enabled](#input\_termination\_protection\_enabled) | Enable protection to avoid accidental production cluster termination | `bool` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC CIDR | `string` | n/a | yes |
| <a name="input_vpc_network_id"></a> [vpc\_network\_id](#input\_vpc\_network\_id) | VPC Network ID | `string` | n/a | yes |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | VPC Network Name | `string` | n/a | yes |

## Outputs

No outputs.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.5 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.postgres](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_secret_manager_secret.postgres_password](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.postgres_password](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_networking_connection.private_service_connection_pg](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_sql_database_instance.postgres_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.postgres](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_password.postgres](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | disk size in GBs | `number` | `20` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to Apply | `map(string)` | n/a | yes |
| <a name="input_postgres_subnet_cidr"></a> [postgres\_subnet\_cidr](#input\_postgres\_subnet\_cidr) | Postgres CIDR Range | `string` | n/a | yes |
| <a name="input_production"></a> [production](#input\_production) | True if this is a production cluster | `bool` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Customer Name | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |
| <a name="input_vpc_network_id"></a> [vpc\_network\_id](#input\_vpc\_network\_id) | VPC Network ID | `string` | n/a | yes |

## Outputs

No outputs.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.redis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_redis_instance.redis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance) | resource |
| [google_secret_manager_secret.redis_password](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.redis_password](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_networking_connection.private_service_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_project_name"></a> [gcp\_project\_name](#input\_gcp\_project\_name) | GCP Project ID | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to Apply | `map(string)` | n/a | yes |
| <a name="input_memory_size_gb"></a> [memory\_size\_gb](#input\_memory\_size\_gb) | GBs of ram for redis | `number` | `8` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Customer Name | `string` | n/a | yes |
| <a name="input_redis_subnet_cidr"></a> [redis\_subnet\_cidr](#input\_redis\_subnet\_cidr) | Redis CIDR Range | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |
| <a name="input_vpc_network_id"></a> [vpc\_network\_id](#input\_vpc\_network\_id) | VPC Network ID | `string` | n/a | yes |

## Outputs

No outputs.
