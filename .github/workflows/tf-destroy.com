name: Terraform Destroy
on:
  workflow_dispatch:
    inputs:
      project_id:
        description: "GCP project ID"
        required: true
      region:
        description: "Region"
        required: true
        default: us-central1

permissions:
  contents: read
  id-token: write

env:
  TF_IN_AUTOMATION: true
  TF_INPUT: false
  TF_CLI_ARGS_init: -input=false
  TF_CLI_ARGS_destroy: -auto-approve -lock-timeout=5m

jobs:
  destroy:
    runs-on: ubuntu-latest
    concurrency:
      group: tf-${{ github.ref }}-apply
      cancel-in-progress: false

    steps:
      - uses: actions/checkout@v4

      - name: Auth (WIF)
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: ${{ secrets.GCP_WIF_PROVIDER }}
          service_account: ${{ secrets.GCP_WIF_SA }}

      - uses: google-github-actions/setup-gcloud@v2
      - uses: hashicorp/setup-terraform@v3

      - name: Backend config
        working-directory: terraform
        run: |
          cat > backend.hcl <<'HCL'
          bucket = "YOUR_TF_STATE_BUCKET"
          prefix = "terraform/state/dev"
          HCL

      - name: Init
        working-directory: terraform
        run: terraform init -backend-config=backend.hcl

      - name: Destroy
        working-directory: terraform
        run: |
          terraform destroy \
            -var="project_id=${{ inputs.project_id }}" \
            -var="region=${{ inputs.region }}"
