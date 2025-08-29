What this sets up

•  Project & billing — Creates a new project bound to your billing account; optional folder placement; labels for governance.
•  APIs — Enables essential services (Compute, IAM, Networking, KMS, Secret Manager, Cloud Logging/Monitoring, etc.).
•  Networking — One custom VPC; regional subnets with VPC Flow Logs and Private Google Access; per‑region Cloud Router + Cloud NAT for egress-only outbound.
•  Firewall — Default deny ingress (implicit) plus explicit egress-allow; an optional IAP SSH rule you can tag onto VMs when needed.
•  Identity — A workload Service Account plus flexible, least-privilege project IAM bindings.
•  Storage — A GCS bucket with uniform bucket-level access, versioning, and optional retention lock

Files

•  main.tf — Providers and all resources.
•  variables.tf — Inputs with same defaults and types.
•  outputs.tf — Common outputs for scripting/integration.
•  terraform.tfvars — Example values you can tweak.

terraform/
├── envs/
│   ├── dev/
│   │   ├── main.tf          # calls secure-baseline modules with prod vars
│   │   ├── variables.tf     # prod-specific inputs
│   │   ├── outputs.tf
│   │   └── terraform.tfvars # e.g., project_id, subnet ranges, IAM principals
│
├── modules/
│   ├── project/
│   │   ├── main.tf          # baseline project creation + APIs
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── networking/
│   │   ├── main.tf          # VPC, subnets, firewall baseline rules
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── iam/
│   │   ├── main.tf          # baseline IAM roles, org policy bindings
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── storage/
│   │   ├── main.tf          # secure GCS buckets (logging, backups)
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── logging-monitoring/
│   │   ├── main.tf          # Cloud Logging, Cloud Monitoring, alert policies
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security-controls/
│   │   ├── main.tf          # Org policy constraints, CMEK, audit configs
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ...
│
├── global/
│   ├── backend.tf           # remote state in secure GCS bucket
│   ├── provider.tf          # GCP provider block + impersonation (if used)
│   ├── variables.tf         # org_id, billing_account, global labels
│   └── versions.tf
│
├── README.md
└── .gitignore
