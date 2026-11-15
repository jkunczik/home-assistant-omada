ARG BUILD_ARCH=amd64

# 1. Get No-AVX MongoDB (AMD64 only)
# We force platform to amd64 so this stage succeeds even on arm64 builders
FROM --platform=linux/amd64 jeruntu/mongodb-no-avx:latest AS mongo-source

# 2. Define base images
FROM ghcr.io/home-assistant/amd64-base-ubuntu:24.04 AS base-amd64
FROM ghcr.io/home-assistant/aarch64-base-ubuntu:24.04 AS base-arm64

# 3. Select correct base
ARG TARGETARCH
FROM base-${TARGETARCH}

COPY install.sh /
COPY healthcheck.sh /

# Home Assistant adds BUILD_ARCH, and buildx adds TARGETARCH; save the right one as ARCH
ARG TARGETARCH
ARG BUILD_ARCH
ARG ARCH=${TARGETARCH:-${BUILD_ARCH:-}}

# install version
ARG INSTALL_VER

# install omada controller (includes standard mongo)
RUN /install.sh && rm /install.sh

# 4. Conditionally overwrite MongoDB for AMD64
COPY --from=mongo-source /usr/local/bin/mongod /tmp/mongod-no-avx

RUN if [ "${TARGETARCH}" = "amd64" ]; then \
        echo "AMD64 detected: Installing No-AVX MongoDB binary..."; \
        mv /tmp/mongod-no-avx /usr/bin/mongod; \
        chmod +x /usr/bin/mongod; \
    else \
        echo "ARM64 detected: Keeping standard MongoDB binary..."; \
        rm /tmp/mongod-no-avx; \
    fi

COPY entrypoint.sh /

# Set s6-overlay timeouts
# S6_SERVICES_GRACETIME: time (ms) to wait for services to stop (default 3000)
ENV S6_SERVICES_GRACETIME=55000

COPY rootfs /

WORKDIR /opt/tplink/EAPController/lib
EXPOSE 8088 8043 8044 8843 29810/udp 29811 29812 29813 29814
HEALTHCHECK --start-period=6m CMD /healthcheck.sh
VOLUME ["/data"]
ENTRYPOINT ["/init"]
