# gcpa-data-engineering-certification
This GCPA Data Engineering Repo is meant to be used for everything related to my GCPA Certification journey

# pre-requisite
must install 
  - google sdk and gcloud-cli
  - terraform

# Required repository secrets

GCP_WIF_PROVIDER – Full resource name of your Workload Identity Federation provider.
Example: projects/123456789/locations/global/workloadIdentityPools/gh-pool/providers/gh-provider

GCP_WIF_SA – Email of the GCP service account the workflow will impersonate.
Example: ci-terraform@integral-league-470114-n3.iam.gserviceaccount.com

GCP_PROJECT_ID – Target GCP project ID.
Example: integral-league-470114-n3

GCP_REGION – Default region for resources.
Example: us-east4

GCP_ZONE – Zone for the VM.
Example: us-east4-c

ALLOWED_CIDR – CIDR allowed to reach HTTP/HTTPS (firewall).
Example: 203.0.113.45/32 (your IP) — or omit to default to 0.0.0.0/0.

Already provided by GitHub (no action needed)

GITHUB_TOKEN – Auto-injected per run; used by the destroy workflow to download artifacts.

Optional (only if you change the setup)

If you choose key-based auth instead of WIF:

GCP_SA_KEY – Entire JSON key for a service account (less secure; not recommended when WIF is available).

If you pull a private GHCR image: no extra secrets needed, but ensure the workflow has permissions: packages: read. (Your GITHUB_TOKEN will handle the pull as long as the image is under the same owner and visibility allows it.)

If you add other env-driven TF vars later: create secrets like TF_VAR_... and pass them through with -var or environment.

Minimum roles for the WIF service account

Make sure the SA in GCP_WIF_SA has roles your code needs, e.g.:

roles/storage.admin (create/delete the ephemeral state bucket)

For your resources: likely roles/compute.admin, roles/compute.networkAdmin, and whatever else your Terraform uses.

That’s it—add those secrets and both workflows you set up will run without prompting for inputs (except run_id & artifact_name on the destroy workflow).

# reference

https://cloud.google.com/sdk/docs/install
https://developer.hashicorp.com/terraform/install
gscloud cheat sheet: https://cloud.google.com/sdk/docs/cheatsheet
