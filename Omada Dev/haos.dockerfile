FROM ghcr.io/home-assistant/aarch64-base-ubuntu:22.04

COPY install.sh /
COPY healthcheck.sh /

# ARM64-only image; hardcode ARCH so install.sh selects MongoDB 7.0 on Ubuntu 22.04 (jammy).
ARG ARCH=arm64

# HA supervisor passes the add-on version as BUILD_VERSION; CI passes INSTALL_VER directly.
ARG BUILD_VERSION
ARG INSTALL_VER=${BUILD_VERSION}

RUN /install.sh && rm /install.sh

COPY entrypoint.sh /

ENV S6_SERVICES_GRACETIME=55000

COPY rootfs /

WORKDIR /opt/tplink/EAPController/lib
EXPOSE 8088 8043 8843 29810/udp 29811 29812 29813 29814
HEALTHCHECK --start-period=6m CMD /healthcheck.sh
VOLUME ["/data"]
ENTRYPOINT ["/init"]
