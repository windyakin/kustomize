FROM ubuntu:22.04

COPY download_kustomize.sh download_urls.txt /tmp/

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
  && chmod +x /tmp/download_kustomize.sh \
  && /tmp/download_kustomize.sh \
  && apt-get remove -y \
    curl \
    ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
