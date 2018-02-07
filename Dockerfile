FROM alpine

ENV NOMAD_VERSION=0.7.1
ENV GLIBC_VERSION=2.27-r0

RUN apk add curl bash jq coreutils python --no-cache
RUN curl -Ls https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk > /tmp/glibc-${GLIBC_VERSION}.apk && \
    apk add --no-cache --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk && \
    rm /tmp/glibc-${GLIBC_VERSION}.apk

ADD https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip nomad.zip

RUN unzip nomad.zip && \
    rm nomad.zip && \
    mv nomad /usr/bin/nomad && \
    chmod +x /usr/bin/nomad

COPY bin /opt/resource
