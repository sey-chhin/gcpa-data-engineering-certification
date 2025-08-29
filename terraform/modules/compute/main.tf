resource "google_compute_instance" "vm" {
  name         = var.e2_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnetwork

    access_config {
      // Enables external IP
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = var.scopes
  }

  tags = var.tags
}
