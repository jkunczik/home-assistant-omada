#!/usr/bin/env bash

set -e

# Call mbentley install script
./mbentley/install.sh

# =====================================
# Home Assistant specific preprocessing
# =====================================

# Install bashio
apt-get update
apt-get install --no-install-recommends -y  -y ca-certificates curl jq
BASHIO_VERSION="0.16.2"
echo "**** Install BashIO ${BASHIO_VERSION}, for parsing HASS AddOn options ****"
curl -J -L -o /tmp/bashio.tar.gz "https://github.com/hassio-addons/bashio/archive/refs/tags/v${BASHIO_VERSION}.tar.gz"
mkdir /tmp/bashio
tar zxvf /tmp/bashio.tar.gz  --strip 1 -C /tmp/bashio
mv /tmp/bashio/lib /usr/lib/bashio
ln -s /usr/lib/bashio/bashio /usr/bin/bashio

# symlink to home assistant data dir to the omada data dir to make configuration persistent
mkdir -p /data

mv /opt/tplink/EAPController/data /opt/tplink/EAPController/data_backup
ln -s /data/data /opt/tplink/EAPController/data

rm -rf /opt/tplink/EAPController/logs
ln -s /data/logs /opt/tplink/EAPController/logs
