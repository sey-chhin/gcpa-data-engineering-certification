labels = {
  env   = "sandbox"
  owner = "cloud-team"
}

enable_apis = [
  "compute.googleapis.com",
  "iam.googleapis.com",
  "logging.googleapis.com",
  "monitoring.googleapis.com"
]

vpc_name = "vpc-sandbox"

# backend_bucket = "pde-exam-bucket-1"

subnet_cidrs = {
  primary = "10.10.0.0/24"
}

subnets = [
  { name = "sandbox-use1", cidr = "10.0.0.0/20", region = "us-east4" },
  #   { name = "sandbox-usc1", cidr = "10.1.0.0/20", region = "us-central1" }
]

# workload_sa_id           = "runtime-sa"
# workload_sa_display_name = "Runtime Service Account"

iam_bindings = [
  { role = "roles/viewer", member = "user:schhin@gmail.com" },
  { role = "roles/storage.admin", member = "user:schhin@gmail.com" }
]

storage_buckets = [
  { name = "pde-exam-bucket-1", location = "US" }
]

region = "us-east4"


# e2 machines

e2_name           = "e2-sandbox"
boot_image        = "projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2504-plucky-amd64-v20250828"
disk_size_gb      = "10"
disk_type         = "pd-balanced"
tags              = ["http-server", "https-server"]
subnetwork        = "default"
workload_sa_email = ""
zone              = "us-east4-c"
machine_type      = "e2-medium"