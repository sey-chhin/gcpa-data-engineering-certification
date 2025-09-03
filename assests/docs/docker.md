🧪 Step-by-Step: Build and Run Locally
1. Build the image locally
Make sure you're in the directory with your Dockerfile, then run:

bash
docker build -t terraform-env:dev .
This tags the image as terraform-env with a local dev tag.

2. Run the container interactively
To test it manually:

bash
docker run -it --rm terraform-env:dev bash
This opens a shell inside the container so you can verify Terraform is installed, check environment setup, etc.

3. Run a Terraform command directly
If you just want to validate the install:

bash
docker run --rm terraform-env:dev terraform version
4. Mount your local Terraform config (optional)
To test with real .tf files:

bash
docker run -it --rm \
  -v "$(pwd)/your-terraform-dir":/workspace \
  -w /workspace \
  terraform-env:dev bash
This mounts your local directory into the container and sets it as the working directory.