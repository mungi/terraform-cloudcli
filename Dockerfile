FROM python:3.8-alpine

ENV TERRAFORM_VERSION 0.12.24

RUN apk update && \
    apk -uv add --no-cache jq && \
    apk -uv add --no-cache --virtual .build-deps gcc build-base libffi-dev openssl-dev && \
    pip3 install --upgrade --no-cache-dir pip awscli gsutil az-cli && \
    apk del --no-network --no-cache .build-deps && \
    rm -rf /var/cache/apk/*

RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O temp.zip && \
    unzip temp.zip -d /usr/local/bin/ && \
    rm temp.zip

ENTRYPOINT ["sh", "-c"]
CMD ["terraform"]
