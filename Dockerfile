FROM python:3.8-alpine

### Set Terraform , GCP CLI Version
ARG TERRAFORM_VERSION=0.12.24
ARG CLOUD_SDK_VERSION=285.0.1

### HELM , aws-iam-authenticator Version
ARG HELM_VERSION=3.1.2
ARG AWS_IAM_AUTH_VERSION=0.5.0

### AWS CLI, Azure CLI : Latest

ENV HELM_FILE=https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
ENV AWS_IAM_AUTH_FILE=https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${AWS_IAM_AUTH_VERSION}/aws-iam-authenticator_${AWS_IAM_AUTH_VERSION}_linux_amd64 
ENV PATH=/google-cloud-sdk/bin:$PATH

# Install AWS CLI: aws , Azure CLI: az
RUN apk update && \
    apk -uv add --no-cache jq groff && \
    apk -uv add --no-cache --virtual .build-deps gcc build-base libffi-dev openssl-dev && \
    pip3 install --upgrade --no-cache-dir pip awscli az-cli ansible && \
    apk del --no-network --no-cache .build-deps && \
    rm -rf /var/cache/apk/*

# Install GCP CLI: gcloud gsutil
RUN wget -q --no-cache -O- https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz | tar -xz && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image

# Install Terraform
RUN wget -q -O- https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O temp.zip && \
    unzip temp.zip -d /usr/local/bin/ && rm -f temp.zip

# Install kubectl helm aws-iam-authenticator eksctl
RUN KUBECTL_VERSION=$(wget --no-cache -qO- https://storage.googleapis.com/kubernetes-release/release/stable.txt) && \
    wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O /usr/bin/kubectl && chmod +x /usr/bin/kubectl && \
    wget -q -O- ${HELM_FILE} | tar xz && mv linux-amd64/helm /usr/bin/ && rm -rf linux-amd64  && \
    wget -q ${AWS_IAM_AUTH_FILE} -O /usr/bin/aws-iam-authenticator && chmod +x /usr/bin/aws-iam-authenticator  && \
    wget -q -O- "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /usr/bin/

# Just describe the versions at log
RUN LINES=$(printf -- '-%.0s' $(seq 80); echo "") && echo $LINES && \
    terraform --version && echo $LINES && \
    aws --version && echo $LINES && \
    az version -o yaml && echo $LINES && \
    gcloud version && echo $LINES && \
    kubectl version -o yaml --short --client && echo $LINES && \
    helm version --short && echo $LINES && \
    aws-iam-authenticator version -o yaml && echo $LINES && \
    eksctl version && echo $LINES && \
    ansible --version

ENTRYPOINT ["sh", "-c"]
CMD ["terraform"]
