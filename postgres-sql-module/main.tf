resource "google_sql_database_instance" "postgres_instance" {
  name                = var.project_name
  database_version    = "POSTGRES_12"
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
      allocated_ip_range = var.address_space_name
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