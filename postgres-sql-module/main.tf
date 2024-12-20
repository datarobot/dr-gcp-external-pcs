resource "google_compute_global_address" "postgres" {
  project       = var.project_name
  name          = "${var.project_name}-postgres"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = split("/", var.postgres_subnet_cidr)[0]
  prefix_length = split("/", var.postgres_subnet_cidr)[1]
  network       = var.vpc_network_id
}

resource "google_service_networking_connection" "private_service_connection_pg" {
  network = var.vpc_network_id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.postgres.name
  ]
}

resource "google_sql_database_instance" "postgres_instance" {
  project             = var.project_name
  name                = "${var.project_name}-postgres"
  database_version    = "POSTGRES_13"
  deletion_protection = var.production

  settings {
    availability_type     = "REGIONAL"
    disk_size             = var.disk_size
    disk_type             = "PD_SSD"
    disk_autoresize_limit = 500
    tier                  = "db-custom-4-16384"
    user_labels           = var.labels

    ip_configuration {
      ipv4_enabled       = false
      private_network    = var.vpc_id
      allocated_ip_range = google_compute_global_address.postgres.name
      require_ssl        = false
      ssl_mode           = "ENCRYPTED_ONLY" # Only allows connections using SSL/TLS encryption. Certificates will not be verified.
    }

    backup_configuration {
      enabled                        = true
      start_time                     = "20:55"
      location                       = null
      point_in_time_recovery_enabled = false
      transaction_log_retention_days = null
      backup_retention_settings {
        retained_backups = 365
        retention_unit   = "COUNT"
      }
    }

    maintenance_window {
      day          = 7
      hour         = 23
      update_track = "stable"
    }

    database_flags {
      name  = "log_temp_files"
      value = "0"
    }

    database_flags {
      name  = "log_checkpoints"
      value = "on"
    }

    database_flags {
      name  = "log_connections"
      value = "on"
    }

    database_flags {
      name  = "log_disconnections"
      value = "on"
    }

    database_flags {
      name  = "log_lock_waits"
      value = "on"
    }
  }
  lifecycle {
    ignore_changes = [
      settings[0].disk_size,
    ]
  }
}

resource "random_password" "postgres" {
  length           = 20
  special          = false
  override_special = "_"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "google_sql_user" "postgres" {
  project  = var.project_name
  name     = "postgres"
  instance = google_sql_database_instance.postgres_instance.name
  password = random_password.postgres.result
}

resource "google_secret_manager_secret" "postgres_password" {
  project   = var.project_name
  secret_id = "${var.project_name}-postgres-password"

  labels = var.labels
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "postgres_password" {
  secret      = google_secret_manager_secret.postgres_password.id
  secret_data = random_password.postgres.result
}
