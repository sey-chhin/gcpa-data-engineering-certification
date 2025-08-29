What this sets up

•  Project & billing — Creates a new project bound to your billing account; optional folder placement; labels for governance.
•  APIs — Enables essential services (Compute, IAM, Networking, KMS, Secret Manager, Cloud Logging/Monitoring, etc.).
•  Networking — One custom VPC; regional subnets with VPC Flow Logs and Private Google Access; per‑region Cloud Router + Cloud NAT for egress-only outbound.
•  Firewall — Default deny ingress (implicit) plus explicit egress-allow; an optional IAP SSH rule you can tag onto VMs when needed.
•  Identity — A workload Service Account plus flexible, least-privilege project IAM bindings.
•  Storage — A GCS bucket with uniform bucket-level access, versioning, and optional retention lock

Files

•  main.tf — Providers and all resources.
•  variables.tf — Inputs with sane defaults and types.
•  outputs.tf — Common outputs for scripting/integration.
•  terraform.tfvars — Example values you can tweak.
