ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.21-7.10.24

FROM docker.io/tiredofit/${DISTRO}:${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG MOSQUITTO_VERSION

ENV MOSQUITTO_VERSION=${MOSQUITTO_VERSION:-"v2.0.20"} \
    MOSQUITTO_REPO_URL=https://github.com/eclipse/mosquitto \
    IMAGE_NAME="tiredofit/mosquitto" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-mosquitto"

RUN source /assets/functions/00-container && \
    set -x && \
    addgroup -g 1883 mosquitto && \
    adduser -S -D -G mosquitto -u 1883 -h /var/lib/mosquitto/ mosquitto && \
    package update && \
    package upgrade && \
    package install .mosquitto-build-deps \
                    c-ares-dev \
                    cjson-dev \
                    libwebsockets-dev \
                    libxslt-dev \
                    docbook-xsl \
                    build-base \
                    openssl-dev \
                    util-linux-dev \
                    && \
    package install .mosquitto-run-deps \
                    libxslt \
                    openssl \
                    libwebsockets \
                    && \
    \
    clone_git_repo "${MOSQUITTO_REPO_URL}" "${MOSQUITTO_VERSION}" /usr/src/mosquitto && \
    cd /usr/src/mosquitto && \
    make \
            -j$(nproc) \
            WITH_MEMORY_TRACKING=no \
            WITH_WEBSOCKETS=yes \
            WITH_CJSON=yes \
            WITH_SRV=yes \
            WITH_ADNS=no \
            prefix=/usr \
            install \
            && \
    \
    package remove \
                    .mosquitto-build-deps \
                    && \
    package cleanup && \
    rm -rf /usr/src/mosquitto

ADD install/ /
