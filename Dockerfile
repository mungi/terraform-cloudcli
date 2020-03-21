FROM python:3.8-alpine

ENV TERRAFORM_VERSION 0.12.24
ENV CLOUD_SDK_VERSION=285.0.1
ENV PATH=/google-cloud-sdk/bin:$PATH

# Install AWS CLI: aws , Azure CLI: az
RUN apk update && \
    apk -uv add --no-cache jq && \
    apk -uv add --no-cache --virtual .build-deps gcc build-base libffi-dev openssl-dev && \
    pip3 install --upgrade --no-cache-dir pip awscli az-cli && \
    apk del --no-network --no-cache .build-deps && \
    rm -rf /var/cache/apk/*

# Install GCP CLI: gcloud gsutil
RUN wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz -O temp1.tgz && \
    tar xzf temp1.tgz && rm -f temp1.tgz && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image

# Install Terraform
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O temp2.zip && \
    unzip temp2.zip -d /usr/local/bin/ && rm -f temp2.zip

RUN terraform --version && aws --version && az --version && gcloud --version

ENTRYPOINT ["sh", "-c"]
CMD ["terraform"]
