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
    lsb-release

# Install Terraform manually
ENV TERRAFORM_VERSION=1.6.6

RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm terraform.zip


# Verify Terraform install
RUN terraform --version

# Set working directory
WORKDIR /workspace

# Default shell
CMD [ "bash" ]

# Display success message
RUN echo "SUCCESS!"
