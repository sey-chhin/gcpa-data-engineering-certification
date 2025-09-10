# data "google_project" "this" {
#   project_id = var.project_id
# }

# locals {
#   # <PROJECT_NUMBER>-compute@developer.gserviceaccount.com
#   default_compute_sa = "${data.google_project.this.number}-compute@developer.gserviceaccount.com"
#   vm_sa_email        = coalesce(var.service_account_email, local.default_compute_sa)
# }

resource "google_compute_instance" "vm" {
  name           = var.e2_name
  machine_type   = var.machine_type
  zone           = var.zone
  project        = var.project_id
  enable_display = var.enable_display
  labels         = var.labels

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
    stack_type = var.stack_type

    access_config {
      // Enables external IP
      # Enables external IP; match Google sample tier
      network_tier = var.network_tier
    }
  }

  scheduling {
    automatic_restart   = var.automatic_restart
    on_host_maintenance = var.on_host_maintenance
    preemptible         = var.preemptible
    provisioning_model  = var.provisioning_model
  }

  shielded_instance_config {
    enable_integrity_monitoring = var.shield_enable_integrity_monitoring
    enable_secure_boot          = var.shield_enable_secure_boot
    enable_vtpm                 = var.shield_enable_vtpm
  }
  dynamic "service_account" {
    for_each = var.service_account_email == null ? [1] : [var.service_account_email]
    content {
      email  = var.service_account_email == null ? null : service_account.value
      scopes = var.scopes
    }
  }
  # service_account {
  #   # email  = local.vm_sa_email
  #   scopes = var.scopes
  #  }


  tags = var.tags
}
