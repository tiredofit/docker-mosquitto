# SPDX-FileCopyrightText: © 2025 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG BASE_IMAGE
ARG DISTRO
ARG DISTRO_VARIANT

FROM ${BASE_IMAGE}:${DISTRO}_${DISTRO_VARIANT}

LABEL \
        org.opencontainers.image.title="Mosquitto" \
        org.opencontainers.image.description="MQTT Broker" \
        org.opencontainers.image.url="https://hub.docker.com/r/nfrastack/mosquitto" \
        org.opencontainers.image.documentation="https://github.com/nfrastack/container-mosquitto/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/nfrastack/container-mosquitto.git" \
        org.opencontainers.image.authors="Nfrastack <code@nfrastack.com>" \
        org.opencontainers.image.vendor="Nfrastack <https://www.nfrastack.com>" \
        org.opencontainers.image.licenses="MIT"

ARG \
    MOSQUITTO_REPO_URL="https://github.com/eclipse/mosquitto" \
    MOSQUITTO_VERSION="v2.0.22"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

ENV \
    CONTAINER_ENABLE_SCHEDULING=TRUE \
    IMAGE_NAME="nfrastack/mosquitto" \
    IMAGE_REPO_URL="https://github.com/nfrastack/container-mosquitto"

RUN echo "" && \
    MOSQUITTO_BUILD_DEPS_ALPINE=" \
                            build-base \
                            c-ares-dev \
                            cjson-dev \
                            docbook-xsl \
                            libwebsockets-dev \
                            libxslt-dev \
                            openssl-dev \
                            util-linux-dev \
                        " \
                        && \
    MOSQUITTO_RUN_DEPS_ALPINE=" \
                            libwebsockets \
                            libxslt \
                            openssl \
                        " \
                        && \
    \
    source /container/base/functions/container/build && \
    container_build_log image && \
    create_user mosquitto 1883 mosquitto 1883 /var/lib/mosquitto && \
    package update && \
    package upgrade && \
    package install \
                        MOSQUITTO_BUILD_DEPS \
                        MOSQUITTO_RUN_DEPS \
                        && \
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
    container_build_log add "Mosquitto" "${MOSQUITTO_VERSION}" "${MOSQUITTO_REPO_URL}" && \
    package remove \
                    MOSQUITTO_BUILD_DEPS \
                    && \
    package cleanup

COPY rootfs/ /
