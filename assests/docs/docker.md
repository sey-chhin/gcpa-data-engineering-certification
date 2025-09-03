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




'''
docker run -it --rm terraform-env:dev bash

Hooray! Oh My Zsh has been updated!

To keep up with the latest news and updates, follow us on X: @ohmyzsh
Want to get involved in the community? Join our Discord: Discord server
Get your Oh My Zsh swag at: Planet Argon Shop
➜  gcpa-data-engineering-certification 
➜  gcpa-data-engineering-certification git:(dev3) ✗ docker run -it --rm terraform-env:dev bash
root@121b4866df6e:/workspace# echo $HOSTNAME
121b4866df6e
root@121b4866df6e:/workspace#       
```


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


# Push your image to GHCR
# 1) Login (create a PAT with "write:packages"; SSO-enable it if your org requires)
echo $GH_PAT | docker login ghcr.io -u <GITHUB_USERNAME> --password-stdin

# 2) Build the image from your Dockerfile
docker build -t ghcr.io/<OWNER>/<IMAGE_NAME>:<TAG> .

# 3) Push it
docker push ghcr.io/<OWNER>/<IMAGE_NAME>:<TAG>

```
➜  terraform-env git:(dev3) ✗ docker build -t ghcr.io/schhin/terraform-env:latest .
[+] Building 4.2s (11/11) FINISHED                                                                                                                    docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                  0.0s
 => => transferring dockerfile: 817B                                                                                                                                  0.0s
 => [internal] load metadata for docker.io/library/ubuntu:22.04                                                                                                       3.9s
 => [auth] library/ubuntu:pull token for registry-1.docker.io                                                                                                         0.0s
 => [internal] load .dockerignore                                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                                       0.0s
 => [1/6] FROM docker.io/library/ubuntu:22.04@sha256:4e0171b9275e12d375863f2b3ae9ce00a4c53ddda176bd55868df97ac6f21a6e                                                 0.0s
 => => resolve docker.io/library/ubuntu:22.04@sha256:4e0171b9275e12d375863f2b3ae9ce00a4c53ddda176bd55868df97ac6f21a6e                                                 0.0s
 => CACHED [2/6] RUN apt-get update && apt-get install -y     gnupg     software-properties-common     curl     unzip     ca-certificates     lsb-release             0.0s
 => CACHED [3/6] RUN curl -fsSL https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip     -o terraform.zip &&     unzip terraform.zip &&     0.0s
 => CACHED [4/6] RUN terraform --version                                                                                                                              0.0s
 => CACHED [5/6] WORKDIR /workspace                                                                                                                                   0.0s
 => [6/6] RUN echo "SUCCESS!"                                                                                                                                         0.1s
 => exporting to image                                                                                                                                                0.1s
 => => exporting layers                                                                                                                                               0.0s
 => => exporting manifest sha256:53d1322702f9cd37aad127c64a0112a04554ba13640b320f846f14714635c8cf                                                                     0.0s
 => => exporting config sha256:64fdcd209d1c8add3f3c1dff263d85ed06f40d3c7b8cae8db28771a97976ef1b                                                                       0.0s
 => => exporting attestation manifest sha256:66c2beed62e8dc7b581161f8e699de69c4e5fc944bc3edbaef4d896ab2b2ebce                                                         0.0s
 => => exporting manifest list sha256:7ff73e25c3cfd44ddb14c69bf4f2d955ca645aa96f2996a0b5a575875a0dd46b                                                                0.0s
 => => naming to ghcr.io/schhin/terraform-env:latest                                                                                                                  0.0s
 => => unpacking to ghcr.io/schhin/terraform-env:latest   
```

Quick example:

IMAGE=ghcr.io/<OWNER>/myapp:latest
docker build -t $IMAGE .
docker push $IMAGE

Optional: via GitHub Actions
name: Build & Push to GHCR
on: { push: { branches: [ "main" ] } }
permissions: { contents: read, packages: write }
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      - uses: docker/build-push-action@v6
        with:
          context: .
          push: true
          tags: ghcr.io/${{ github.repository_owner }}/myapp:latest


If you literally wanted github.io: GitHub Pages hosts static files only. You’d build your site (optionally with Docker), then publish the static output to Pages—not the container image.