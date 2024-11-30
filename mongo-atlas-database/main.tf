resource "mongodbatlas_project" "gcp_atlas" {
  name   = "${var.project_name}-datarobot"
  org_id = var.atlas_org_id

  is_collect_database_specifics_statistics_enabled = true
  is_data_explorer_enabled                         = true
  is_performance_advisor_enabled                   = true
  is_realtime_performance_panel_enabled            = true
  is_schema_advisor_enabled                        = true
}


resource "mongodbatlas_advanced_cluster" "cluster" {
  project_id                     = mongodbatlas_project.gcp_atlas.id
  name                           = "${var.project_name}-dratlas"
  mongo_db_major_version         = var.mongodb_version
  cluster_type                   = "REPLICASET"
  pit_enabled                    = true
  termination_protection_enabled = var.termination_protection_enabled
  version_release_system         = "LTS"
  backup_enabled                 = true
  replication_specs {
    num_shards = 1
    region_configs {
      provider_name = "GCP"
      region_name   = var.atlas_gcp_region
      priority      = 7
      electable_specs {
        node_count    = 3
        instance_size = var.atlas_instance_type
      }
      auto_scaling {
        disk_gb_enabled = true
      }
    }
  }
  disk_size_gb = var.atlas_disk_size
  advanced_configuration {
    minimum_enabled_tls_protocol                                   = "TLS1_2"
    change_stream_options_pre_and_post_images_expire_after_seconds = -1
  }
  lifecycle {
    ignore_changes = [
      disk_size_gb
    ]
  }
}

resource "mongodbatlas_cloud_backup_schedule" "default" {
  project_id   = mongodbatlas_project.gcp_atlas.id
  cluster_name = mongodbatlas_advanced_cluster.cluster.name

  policy_item_hourly {
    frequency_interval = 6 #accepted values = 1, 2, 4, 6, 8, 12 -> every n hours
    retention_unit     = "days"
    retention_value    = 7
  }
  policy_item_daily {
    frequency_interval = 1 #accepted values = 1 -> every 1 day
    retention_unit     = "days"
    retention_value    = 30
  }
  policy_item_weekly {
    frequency_interval = 6 # accepted values = 1 to 7 -> every 1=Monday,2=Tuesday,3=Wednesday,4=Thursday,5=Friday,6=Saturday,7=Sunday day of the week
    retention_unit     = "days"
    retention_value    = 30
  }
  policy_item_monthly {
    frequency_interval = 1 # accepted values = 1 to 28 -> 1 to 28 every nth day of the month
    # accepted values = 40 -> every last day of the month
    retention_unit  = "months"
    retention_value = 1
  }
  copy_settings {
    cloud_provider = "GCP"
    frequencies = [
      "HOURLY",
      "DAILY",
      "WEEKLY",
      "MONTHLY",
      "ON_DEMAND"
    ]
    region_name         = var.chosen_copy_region
    replication_spec_id = mongodbatlas_advanced_cluster.cluster.replication_specs.*.id[0]
    should_copy_oplogs  = true
  }
}

resource "mongodbatlas_database_user" "db-user" {
  username           = var.atlas_dbuser
  password           = random_password.password_atlas.result
  auth_database_name = "admin"
  project_id         = mongodbatlas_project.gcp_atlas.id
  roles {
    role_name     = "readWrite"
    database_name = "admin"
  }
  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
}

resource "mongodbatlas_project_ip_access_list" "cidr_whitelist" {
  project_id = mongodbatlas_project.gcp_atlas.id
  cidr_block = var.vpc_cidr_block
  comment    = "cidr block for GCP VPC"
}

resource "mongodbatlas_privatelink_endpoint" "gcp_atlas_pl" {
  project_id    = mongodbatlas_project.gcp_atlas.id
  provider_name = "GCP"
  region        = var.gcp_region
  depends_on    = [mongodbatlas_advanced_cluster.cluster]
}


# Create Google 50 Addresses
resource "google_compute_address" "ips_allocated_atlas_pl" {
  count        = 50
  project      = var.gcp_project_name
  name         = "${var.project_name}-atlas-pl-gcp-${count.index}"
  subnetwork   = var.atlas_subnet_name
  address_type = "INTERNAL"
  address      = "${trim(var.atlas_subnet_cidr, "0/24")}${format("%d%d", 1, count.index)}"
  region       = var.gcp_region
  purpose      = "GCE_ENDPOINT"
}

# Create 50 Forwarding rules
resource "google_compute_forwarding_rule" "compute_address_rule_mapping_atlas_pl" {
  count                 = 50
  target                = mongodbatlas_privatelink_endpoint.gcp_atlas_pl.service_attachment_names[count.index]
  project               = google_compute_address.ips_allocated_atlas_pl[count.index].project
  region                = google_compute_address.ips_allocated_atlas_pl[count.index].region
  name                  = google_compute_address.ips_allocated_atlas_pl[count.index].name
  ip_address            = google_compute_address.ips_allocated_atlas_pl[count.index].id
  network               = var.vpc_network_id
  load_balancing_scheme = ""
}

resource "mongodbatlas_privatelink_endpoint_service" "atlas" {
  project_id          = mongodbatlas_privatelink_endpoint.gcp_atlas_pl.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.gcp_atlas_pl.private_link_id
  provider_name       = "GCP"
  endpoint_service_id = var.vpc_network_name
  gcp_project_id      = var.gcp_project_name
  dynamic "endpoints" {
    for_each = mongodbatlas_privatelink_endpoint.gcp_atlas_pl.service_attachment_names

    content {
      ip_address    = google_compute_address.ips_allocated_atlas_pl[endpoints.key].address
      endpoint_name = google_compute_forwarding_rule.compute_address_rule_mapping_atlas_pl[endpoints.key].name
    }
  }
}

resource "random_password" "password_atlas" {
  length           = 20
  special          = false
  override_special = "_"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "google_secret_manager_secret" "atlas_dbpass" {
  project   = var.gcp_project_name
  secret_id = "${var.project_name}-mongo-password"
  labels    = var.labels
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "atlas_dbpass" {
  secret      = google_secret_manager_secret.atlas_dbpass.id
  secret_data = random_password.password_atlas.result
}
