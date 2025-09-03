# Use official Ubuntu base image
FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    gnupg \
    software-properties-common \
    curl \
    unzip \
    ca-certificates \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    gnupg


# Install Terraform manually
ENV TERRAFORM_VERSION=1.6.6

RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm terraform.zip


# Verify Terraform install
RUN terraform --version

# # Set working directory
# WORKDIR /workspace


###### install gcloud sdk ######
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" |tee /etc/apt/sources.list.d/google-cloud-sdk.list

RUN apt-get update && apt-get install -y google-cloud-cli


# Workspace + log dirs and a non-root user
RUN mkdir -p /workspace /secrets /var/log && \
    useradd -m app && chown -R app:app /workspace /secrets /var/log

# Entrypoint that initializes gcloud and logs output
# COPY init-gcloud.sh /usr/local/bin/init-gcloud.sh
# RUN chmod +x /usr/local/bin/init-gcloud.sh



# Verify gcloud install
RUN gcloud version

# Set environment variables for gcloud IMPERSONATE_SA in"
# Docker build --build-arg IMPERSONATE_SA=" " -t terraform-env:dev .
RUN gcloud config set auth/impersonate_service_account "${IMPERSONATE_SA}"
RUN gcloud init

USER app


# Default: run the init script, then drop into bash
# ENTRYPOINT ["/usr/local/bin/init-gcloud.sh"]
CMD ["bash"]
