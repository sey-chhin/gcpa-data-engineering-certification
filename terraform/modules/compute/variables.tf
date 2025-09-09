variable "e2_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}

variable "zone" {
  description = "GCP zone for the VM"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "boot_image" {
  description = "Boot image for the VM"
  type        = string
}

variable "disk_size_gb" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "Type of the boot disk"
  type        = string
  default     = "pd-balanced"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork (name or self_link) for the VM NIC"
  type        = string
}

variable "service_account_email" {
  description = "Service account email for the VM. If null, use the project's default Compute Engine SA."
  type        = string
  default     = null
}

variable "scopes" {
  description = "OAuth scopes for the VM"
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "tags" {
  description = "Network tags for the VM"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Labels applied to networking resources"
  type        = map(string)
  default = {
    owner       = "sey"
    ttl         = "24h"
    purpose     = "lab"
    goog-ec-src = "vm_add-tf"
  }
}

variable "nat_logging" {
  description = "Cloud NAT logging filter: NONE | ERRORS_ONLY | ALL"
  type        = string
  default     = "ERRORS_ONLY"
}

variable "network_tier" {
  description = "Network tier for external access_config"
  type        = string
  default     = "STANDARD"
}

variable "stack_type" {
  description = "Network stack type for the NIC"
  type        = string
  default     = "IPV4_ONLY"
}

variable "enable_display" {
  description = "Enable display device"
  type        = bool
  default     = false
}

variable "automatic_restart" {
  description = "Scheduling: automatic restart"
  type        = bool
  default     = true
}

variable "on_host_maintenance" {
  description = "Scheduling: MIGRATE or TERMINATE"
  type        = string
  default     = "MIGRATE"
}

variable "preemptible" {
  description = "Use preemptible VMs"
  type        = bool
  default     = false
}

variable "provisioning_model" {
  description = "STANDARD or SPOT"
  type        = string
  default     = "STANDARD"
}

variable "shield_enable_integrity_monitoring" {
  description = "Enable Shielded VM integrity monitoring"
  type        = bool
  default     = true
}

variable "shield_enable_secure_boot" {
  description = "Enable Shielded VM secure boot"
  type        = bool
  default     = false
}

variable "shield_enable_vtpm" {
  description = "Enable Shielded VM vTPM"
  type        = bool
  default     = true
}

variable "service_account_email" {
  type        = string
  default     = null
  description = "If set, VM will run as this SA; otherwise default Compute Engine SA."
}