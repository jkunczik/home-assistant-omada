ARG BUILD_ARCH=amd64
# Define base images for different architectures
FROM ghcr.io/home-assistant/amd64-base-ubuntu:24.04 AS base-amd64
FROM ghcr.io/home-assistant/aarch64-base-ubuntu:24.04 AS base-arm64
FROM ghcr.io/home-assistant/aarch64-base-ubuntu:24.04 AS base-aarch64

# TARGETARCH is set by buildx ('arm64'); BUILD_ARCH is set by HA supervisor ('aarch64').
# Fall back from TARGETARCH to BUILD_ARCH so both build paths select the right base.
ARG TARGETARCH
ARG BUILD_ARCH=amd64
FROM base-${TARGETARCH:-${BUILD_ARCH}}

COPY install.sh /
COPY healthcheck.sh /

# Home Assistant adds BUILD_ARCH, and buildx adds TARGETARCH; save the right one as ARCH
ARG TARGETARCH
ARG BUILD_ARCH
ARG ARCH=${TARGETARCH:-${BUILD_ARCH:-}}

# HA supervisor passes the add-on version as BUILD_VERSION; buildx/test_dev.sh pass INSTALL_VER directly.
ARG BUILD_VERSION
ARG INSTALL_VER=${BUILD_VERSION}

# install omada controller (instructions taken from install.sh)
RUN /install.sh && rm /install.sh

# copy entrypoint after the installation, to avoid rebuilding whole image
# entrypoint-rootless.sh is not needed for Home Assistant
COPY entrypoint.sh /

# Set s6-overlay timeouts
# S6_SERVICES_GRACETIME: time (ms) to wait for services to stop (default 3000)
ENV S6_SERVICES_GRACETIME=55000

# Copy rootfs
COPY rootfs /

WORKDIR /opt/tplink/EAPController/lib
EXPOSE 8088 8043 8843 29810/udp 29811 29812 29813 29814
HEALTHCHECK --start-period=6m CMD /healthcheck.sh
VOLUME ["/data"]
ENTRYPOINT ["/init"]
