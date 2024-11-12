# WARNING: Modified Dockerfile to work with Home Assistant. Do not simply overwrite with Dockerfile from mbentley during update
# --------
#
#   Modifications:
#   1. Removed maintainer
#   2. Added ARCH trough home assistant specific `TARGETARCH` and `BUILDARCH`
#   3. Change volume to `VOLUME ["/data"]`

# rebased/repackaged base image that only updates existing packages
ARG BASE=mbentley/ubuntu:20.04
FROM ${BASE}

COPY healthcheck.sh install.sh /
COPY mbentley/install.sh /mbentley/

# Home Assistant adds BUILD_ARCH, and buildx adds TARGETARCH; save the right one as ARCH
ARG TARGETARCH
ARG BUILD_ARCH
ARG ARCH=${TARGETARCH:-${BUILD_ARCH:-}}

# install version (major.minor or full version); OMADA_URL set in install.sh
ARG INSTALL_VER
ARG NO_MONGODB=false

# install omada controller (instructions taken from install.sh)
RUN /install.sh && rm /install.sh && rm /mbentley/install.sh

# copy entrypoint after the installation, to avoid rebuilding whole image
COPY entrypoint.sh /
COPY mbentley/entrypoint-5.x.sh /mbentley/

WORKDIR /opt/tplink/EAPController/lib
EXPOSE 8088 8043 8843 29810/udp 29811 29812 29813 29814
# HEALTHCHECK --start-period=5m CMD /healthcheck.sh
VOLUME ["/data"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/java","-server","-Xms128m","-Xmx1024m","-XX:MaxHeapFreeRatio=60","-XX:MinHeapFreeRatio=30","-XX:+HeapDumpOnOutOfMemoryError","-XX:HeapDumpPath=/opt/tplink/EAPController/logs/java_heapdump.hprof","-Djava.awt.headless=true","--add-opens","java.base/java.util=ALL-UNNAMED","-cp","/opt/tplink/EAPController/lib/*::/opt/tplink/EAPController/properties:","com.tplink.smb.omada.starter.OmadaLinuxMain"]
