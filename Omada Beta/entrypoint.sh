#!/usr/bin/env bashio

# =====================================
# Home Assistant specific preprocessing
# =====================================

# create data and logs dir, if not existing
bashio::log.info "Create 'logs' directory inside persistent /data volume, if it doesn't exist."
mkdir -p "/data/logs"

if [ ! -d /data/data ]; then
  bashio::log.info "/data/data created from docker image backup" && cp -r /opt/tplink/EAPController/data_backup /data/data

  # Check if old directory structure is in place (/data) and copy to (/data/data)
  # This can be removed in the future when everyone has upgraded
  directories=(db keystore pdf)
  for dir in "${directories[@]}"; do
    if [ -d "/data/$dir" ]; then
      cp -r /data/$dir "/data/data/"
      rm -rf /data/$dir
      bashio::log.info "Migrate from old Add-On file structure. Copied /data/$dir to /data/data/$dir"
    else
      bashio::log.info "Already in new file structure. /data/$dir does not exist, skipping."
    fi
  done
fi

# set permissions on /data directory for home assistant persistence
chown -R 508:508 "/data"

# Use SSL Keys from Home Assistant
if bashio::config.true 'enable_hass_ssl'; then
  bashio::log.info "Use SSL from Home Assistant"
  SSL_CERT_NAME=$(bashio::config 'certfile')
  bashio::log.info "SSL certificate: ${SSL_CERT_NAME}"
  SSL_KEY_NAME=$(bashio::config 'keyfile')
  bashio::log.info "SSL private key: ${SSL_KEY_NAME}"
fi

# Source mbentley entrypoint script
source /mbentley/entrypoint-5.x.sh
