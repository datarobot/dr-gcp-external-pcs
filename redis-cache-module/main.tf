resource "google_redis_instance" "redis" {
  name           = "redis"
  tier           = "STANDARD_HA"
  memory_size_gb = var.memory_size_gb

  authorized_network = var.vpc_id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"
  reserved_ip_range  = var.address_space_name
  # transit_encryption_mode = "SERVER_AUTHENTICATION"

  auth_enabled = true

  redis_version = "REDIS_7_0"
  display_name  = "Redis Instance"

  labels = var.labels

  maintenance_policy {
    weekly_maintenance_window {
      day = "SATURDAY"
      start_time {
        hours   = 23
        minutes = 30
        seconds = 0
        nanos   = 0
      }
    }
  }
}

resource "google_secret_manager_secret" "redis_password" {
  secret_id = "${var.project_name}-redis-password"

  labels = var.labels
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "redis_password" {
  secret      = google_secret_manager_secret.redis_password.id
  secret_data = google_redis_instance.redis.auth_string
}
