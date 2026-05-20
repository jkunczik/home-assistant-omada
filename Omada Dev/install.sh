#!/usr/bin/env bash
set -e

# omada controller installer for Home Assistant Add-on

# Default variables
OMADA_DIR="/opt/tplink/EAPController"
ARCH="${ARCH:-}"
INSTALL_VER="${INSTALL_VER:-}"

# Normalize aarch64 (HA supervisor convention) → arm64 (buildx convention)
[ "${ARCH}" = "aarch64" ] && ARCH="arm64"

# Ensure architecture is supported
case "${ARCH}" in
  amd64|arm64) ;;
  *) echo "ERROR: Unsupported architecture: ${ARCH}"; exit 1 ;;
esac

# Install base dependencies
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install --no-install-recommends -y \
  ca-certificates \
  unzip \
  util-linux \
  wget \
  gosu \
  libharfbuzz0b \
  libfontconfig1 \
  net-tools \
  tzdata \
  xz-utils

# Get Omada download URL
OMADA_URL="$(wget -q -O - "https://omada-controller-url.mbentley.net/hooks/omada_ver_to_url?omada-ver=${INSTALL_VER}")"
if [ -z "${OMADA_URL}" ]; then
  echo "ERROR: Could not retrieve Omada URL for version ${INSTALL_VER}"
  exit 1
fi

# Parse version info
OMADA_TAR="${OMADA_URL##*/}"
OMADA_VER="$(echo "${OMADA_TAR}" | awk -F '_v' '{print $2}' | awk -F '_' '{print $1}')"
if [ -z "${OMADA_VER}" ]; then
  # Fallback parsing
  OMADA_VER="$(echo "${OMADA_TAR//[!0-9.]/}" | sed 's/\.*$//' | sed 's/^\.*//' | sed 's/64$//')"
fi
OMADA_MAJOR_VER="$(echo "${OMADA_VER}" | cut -d. -f1)"

echo "Installing Omada Controller v${OMADA_VER} (Major: ${OMADA_MAJOR_VER}) for ${ARCH}..."

# Install MongoDB
if [ "${OMADA_MAJOR_VER}" = "6" ]; then
  apt-get install --no-install-recommends -y gnupg
  eval "$(grep '^VERSION_CODENAME=' /etc/os-release)"
  if [ "${ARCH}" = "arm64" ] && [ "${VERSION_CODENAME}" = "jammy" ]; then
    # MongoDB 8.0 tcmalloc requires 1GB-aligned mmap regions unavailable in HA OS containers.
    # MongoDB 7.0 avoids this; its packages are only available for jammy (Ubuntu 22.04), so
    # this path is taken only when the base image is Ubuntu 22.04 (i.e. the haos.dockerfile).
    MONGO_VER="7.0"
  else
    MONGO_VER="8.0"
  fi
  wget -q -O - "https://www.mongodb.org/static/pgp/server-${MONGO_VER}.asc" \
    | gpg -o "/etc/apt/keyrings/mongodb-server-${MONGO_VER}.gpg" --dearmor
  echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/mongodb-server-${MONGO_VER}.gpg] https://repo.mongodb.org/apt/ubuntu ${VERSION_CODENAME}/mongodb-org/${MONGO_VER} multiverse" \
    > "/etc/apt/sources.list.d/mongodb-org-${MONGO_VER}.list"
  apt-get update
  apt-get install --no-install-recommends -y mongodb-org-server
else
  # Install default MongoDB for older versions (Ubuntu repo)
  apt-get install --no-install-recommends -y mongodb-server-core
fi

# Install Java
if [ "${OMADA_MAJOR_VER}" = "6" ] || ([ "${OMADA_MAJOR_VER}" = "5" ] && [ "$(echo "${OMADA_VER}" | cut -d. -f2)" -ge 4 ]); then
  apt-get install --no-install-recommends -y openjdk-17-jre-headless
else
  apt-get install --no-install-recommends -y openjdk-8-jre-headless
fi

# Download and Extract Omada
cd /tmp
echo "Downloading ${OMADA_URL}..."
wget -nv "${OMADA_URL}"

# Robust Beta Handling
if [[ "${INSTALL_VER}" =~ ^beta.* ]]; then
  case "${OMADA_URL##*.}" in
    zip)
      echo "INFO: Beta zip detected; unzipping and fixing extensions..."
      unzip "${OMADA_TAR}"
      rm -f "${OMADA_TAR}"
      FILENAME_CHECK="$(find . -name "*tar.gz*" | grep -v "zip" | sed 's|^./||')"
      case "${FILENAME_CHECK}" in
        *_tar.gz.gz) mv -v "${FILENAME_CHECK}" "${FILENAME_CHECK/_tar.gz.gz/.tar.gz}" ;;
        *tar.gz.gz)  mv -v "${FILENAME_CHECK}" "${FILENAME_CHECK/tar.gz.gz/.tar.gz}" ;;
      esac
      if [ -z "$(find . -name "*.tar.gz" -maxdepth 1 | sed 's|^./||')" ] && [ -n "$(find . -name "*.tar.gz" | sed 's|^./||')" ]; then
        mv -v "$(find . -name "*.tar.gz" | sed 's|^./||')" .
      fi
      OMADA_TAR="$(ls *.tar.gz)"
      ;;
    gz)
      if ! ls -- *.tar.gz >/dev/null 2>&1; then
        echo "INFO: Beta .gz detected; gunzipping..."
        gunzip "${OMADA_TAR}"
        OMADA_TAR="$(ls -- *.tar.gz*)"
      fi
      ;;
  esac
fi

echo "Extracting ${OMADA_TAR}..."
tar xf "${OMADA_TAR}"
rm -f "${OMADA_TAR}"

# Locate extracted directory
DIR_NAME="$(ls -d Omada_* | head -n 1)"
if [ -z "${DIR_NAME}" ]; then
  echo "ERROR: Could not find extracted Omada directory."
  ls -l
  exit 1
fi
cd "${DIR_NAME}"

# Install files to destination
mkdir -p "${OMADA_DIR}/logs"
DIRS_TO_COPY=("bin" "data" "lib" "properties")
if [ -d "keystore" ]; then DIRS_TO_COPY+=("keystore"); fi
if [ -d "webapps" ]; then DIRS_TO_COPY+=("webapps"); fi

for d in "${DIRS_TO_COPY[@]}"; do
  if [ -d "$d" ]; then cp -r "$d" "${OMADA_DIR}/"; fi
done

# Prepare Properties
# NOTE: MongoDB settings are managed at runtime in entrypoint.sh to ensure
# the controller connects to the S6-managed MongoDB instance.
cp -r "${OMADA_DIR}/properties/" "${OMADA_DIR}/properties.defaults"
ln -sf "$(command -v mongod)" "${OMADA_DIR}/bin/mongod"

# Cleanup
rm -rf /tmp/* /var/lib/apt/lists/*
echo "${OMADA_VER}" > "${OMADA_DIR}/IMAGE_OMADA_VER.txt"

echo "Installation complete."
