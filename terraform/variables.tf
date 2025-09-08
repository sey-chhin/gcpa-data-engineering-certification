variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "project_name" {
  description = "The name of the GCP project"
  type        = string
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}

variable "labels" {
  description = "A map of labels to assign to resources"
  type        = map(string)
  default     = {}
}

variable "org_id" {
  description = "The organization ID"
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "The folder ID"
  type        = string
  default     = ""
}

variable "enable_apis" {
  description = "List of APIs to enable"
  type        = list(string)
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet objects"
  type = list(object({
    name                  = string
    region                = string
    ip_cidr_range         = string
    private_google_access = optional(bool)
    flow_logs             = optional(bool)
    aggregation_interval  = optional(string)
    flow_sampling         = optional(number)
  }))
}

variable "enable_iap_ssh" {
  description = "Enable SSH via IAP"
  type        = bool
  default     = false
}



variable "project_iam" {
  description = "Map of IAM roles to members"
  type        = map(list(string))
}

variable "bucket_name" {
  description = "Name of the storage bucket"
  type        = string
}

variable "bucket_location" {
  description = "Location for the storage bucket"
  type        = string
}

variable "bucket_retention_days" {
  description = "Retention period for the bucket in days"
  type        = number
  default     = 0
}