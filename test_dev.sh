#!/bin/bash
set -e

# Usage: ./test_dev.sh [ARCH] [VERSION] [IMAGE_NAME]
# Example: ./test_dev.sh amd64 beta-6.0.0.23 my-omada:test

# Detect Architecture
HOST_ARCH=$(uname -m)
case "${HOST_ARCH}" in
  x86_64) DEFAULT_ARCH="amd64" ;;
  arm64)  DEFAULT_ARCH="aarch64" ;;
  *)      DEFAULT_ARCH="${HOST_ARCH}" ;;
esac

# Configuration
ARCH="${1:-${DEFAULT_ARCH}}"
VERSION="${2:-beta-6.0.0.23}"
IMAGE_NAME="${3:-omada-dev:test}"
TEST_DIR="/tmp/omada_test_$(date +%s)"

echo "Usage: $0 [ARCH] [VERSION] [IMAGE_NAME]"
echo "  Current ARCH:       ${ARCH}"
echo "  Current VERSION:    ${VERSION}"
echo "  Current IMAGE_NAME: ${IMAGE_NAME}"
echo ""

echo "Building Docker image (Architecture: ${ARCH}, Version: ${VERSION})..."
# Note: We point to "Omada Dev" directory as context
docker build \
  --build-arg BUILD_ARCH="${ARCH}" \
  --build-arg INSTALL_VER="${VERSION}" \
  -t "${IMAGE_NAME}" \
  "Omada Dev"

echo "Creating test environment at ${TEST_DIR}..."
mkdir -p "${TEST_DIR}/data"

# Create options.json
cat > "${TEST_DIR}/data/options.json" <<EOF
{
  "enable_hass_ssl": false,
  "certfile": "/ssl/fullchain.pem",
  "keyfile": "/ssl/privkey.pem",
  "upgrade_https_port": 8043,
  "show_mongodb_logs": false,
  "show_server_logs": true
}
EOF

echo "Starting container..."
echo "Web UI will be available at https://localhost:8043"
echo "Press Ctrl+C to stop."

docker run --rm -it \
  --name omada-dev-test \
  -v "${TEST_DIR}/data:/data" \
  -e "MANAGE_HTTP_PORT=8088" \
  -e "MANAGE_HTTPS_PORT=8043" \
  -p 8043:8043 \
  -p 8088:8088 \
  -p 29810-29816:29810-29816 \
  -p 29810-29816:29810-29816/udp \
  "${IMAGE_NAME}"
