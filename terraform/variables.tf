variable "project_name" {
  description = "Project display name"
  type        = string
}

variable "project_id" {
  description = "Globally-unique project ID"
  type        = string
}

variable "billing_account" {
  description = "Billing account ID (e.g., 0123AB-45CDEF-6789AB)"
  type        = string
}

variable "org_id" {
  description = "Organization ID (use if not placing under a folder)"
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "Folder ID to house the project (takes precedence over org_id)"
  type        = string
  default     = ""
}

variable "region" {
  description = "Default region for regional resources"
  type        = string
  default     = "us-east1"
}

variable "labels" {
  description = "Common labels for governance"
  type        = map(string)
  default     = {}
}

variable "enable_apis" {
  description = "List of project services to enable"
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudkms.googleapis.com",
    "secretmanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ]
}

variable "vpc_name" {
  description = "Name of the custom VPC"
  type        = string
  default     = "vpc-main"
}

variable "subnets" {
  description = "Regional subnets to create"
  type = list(object({
    name                  = string
    region                = string
    ip_cidr_range         = string
    private_google_access = optional(bool, true)
    flow_logs             = optional(bool, true)
    flow_sampling         = optional(number, 0.5)
    aggregation_interval  = optional(string, "INTERVAL_5_MIN")
  }))
  default = [
    {
      name                 = "subnet-use1"
      region               = "us-east1"
      ip_cidr_range        = "10.10.0.0/20"
      private_google_access = true
      flow_logs            = true
      flow_sampling        = 0.5
      aggregation_interval = "INTERVAL_5_MIN"
    },
    {
      name                 = "subnet-usc1"
      region               = "us-central1"
      ip_cidr_range        = "10.20.0.0/20"
      private_google_access = true
      flow_logs            = true
      flow_sampling        = 0.5
      aggregation_interval = "INTERVAL_5_MIN"
    }
  ]
}

variable "enable_iap_ssh" {
  description = "Create a firewall rule to allow SSH via IAP (tagged instances only)"
  type        = bool
  default     = true
}

variable "workload_sa_id" {
  description = "Service account ID (no domain; e.g., app-sa)"
  type        = string
  default     = "workload-sa"
}

variable "workload_sa_display_name" {
  description = "Service account display name"
  type        = string
  default     = "Workload Service Account"
}

variable "project_iam" {
  description = "Map of role => list of members (members like user:alice@example.com, serviceAccount:..., group:...)"
  type        = map(list(string))
  default     = {
    "roles/logging.viewer"    = []
    "roles/monitoring.viewer" = []
  }
}

variable "bucket_name" {
  description = "Name for the secure storage bucket"
  type        = string
  default     = "example-secure-bucket"
}

variable "bucket_location" {
  description = "Bucket location (region or multi-region)"
  type        = string
  default     = "US"
}

variable "bucket_retention_days" {
  description = "Retention period in days (0 to disable retention policy)"
  type        = number
  default     = 0
}
