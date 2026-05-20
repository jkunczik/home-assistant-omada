# Home Assistant Omada Add-On

![CI](https://github.com/jkunczik/home-assistant-omada/workflows/Build%20and%20Push%20Multi-Platform%20Docker%20Image/badge.svg)

This add-on integrates the Omada Controller directly into Home Assistant, supporting both 64-bit ARM and x64 processors.

**NOTE** To upgrade to v6, install the new `Omada Stable v6` add-on!
This requires manually backing up the old stable v5 add-on and apply it to the new stable v6 add-on.

## Add-On Versions

- **Omada Stable v6**: The standard stable branch for Omada major version 6.
  - **Requires:** Modern x86_64 CPU (with AVX support) OR ARM64 CPU with ARMv8.2 support (e.g. Raspberry Pi 5).
  - **Incompatible with:** Raspberry Pi 4 (ARMv8.0) and older x86 CPUs without AVX.
  - **Not recommended for:** Raspberry Pi 5 running **Home Assistant OS** — use the HA OS variant below instead.
- **Omada Stable v6 (HA OS)**: A variant of the v6 add-on for Raspberry Pi 5 running Home Assistant OS.
  - **Designed for:** Raspberry Pi 5 + Home Assistant OS only.
  - **Uses MongoDB 7.0** (Ubuntu 22.04 base) to avoid a tcmalloc memory allocation crash that occurs when running MongoDB 8.0 inside HA OS containers on ARM64.
  - **Not for:** HA Supervised on Raspberry Pi OS, or any x86-64 setup — use the standard Stable v6 instead.
- **Omada Stable v6 NO-AVX**: A variant of the v6 add-on for older x86-64 hardware without AVX support.
  - **Designed for:** Older x86_64 CPUs (e.g., Celeron J1900, older Pentium/Xeon) that lack AVX instructions.
  - **Note:** This does **NOT** enable support for Raspberry Pi 4 (which fails due to missing ARMv8.2 instructions, unrelated to AVX).
- **Omada Stable**: The legacy stable branch for Omada v5.
  - **Recommended for:** Raspberry Pi 4 users and anyone who cannot upgrade to v6 due to hardware limitations.
- **Omada Beta**: Contains beta releases of the Omada Controller.

**NOTE:** To upgrade from v5 to v6, you must install the new `Omada Stable v6` add-on separately. This requires manually backing up your v5 configuration (via the Omada web interface) and restoring it into the new v6 instance. Automatic migration is not supported.

## Installation

To install this third-party add-on:

1. Open **Home Assistant** > **Settings** > **Add-ons** > **Add-on Store**.
2. Click the menu (three dots in the top-right corner) and select **Repositories**.
3. Paste the GitHub repository link into the field at the bottom:  
   `https://github.com/jkunczik/home-assistant-omada`.
4. Refresh the page if needed. The add-on will appear under **Home Assistant Omada**.

## Configuration Options

To use a custom SSL certificate configured for Home Assistant:

1. Enable **Enable Home Assistant SSL** in the add-on configuration.
2. Provide the full paths to the:
   1. **Certificate file**
   2. **Private key**
3. The default paths are compatible with the `LetsEncrypt` add-on.

## Cloudflare Tunnel

If you are using a domain with Cloudflare for DNS,
you can expose your local Home Assistant instance through a Cloudflare Tunnel.
This eliminates the need to open a port on your local network or configure custom certificates.
Cloudflare handles TLS, making this a safer and more streamlined solution.

This [add-on](https://github.com/brenner-tobias/addon-cloudflared)
simplifies the integration of the tunnel into Home Assistant.
Additionally, Omada can be easily added as a secondary host alongside Home Assistant.

Follow the documentation to configure Omada under `Additional Hosts` as follows:

```yaml
- hostname: {MY_HOME_ASSISTANT_DOMAIN}
  service: https://{YOUR_LOCAL_HOME_ASSISTANT_IP}:8043
```

## Developing

For local development, use the `Omada Dev` directory.
A helper script `test_dev.sh` is provided in the root of the repository to simplify building and testing the add-on locally on your machine (macOS/Linux).

### Local Testing with test_dev.sh

The script automatically detects your architecture and creates a mock Home Assistant environment with a valid `options.json`.

```bash
# Run the test script (auto-detects architecture, uses default version)
./test_dev.sh

# Run with specific Architecture
./test_dev.sh amd64

# Run with specific Architecture and Version
./test_dev.sh aarch64 beta-6.0.0.23

# Run with specific Architecture, Version and Image Name
./test_dev.sh amd64 beta-6.0.0.23 my-custom-omada:test
```

The Web UI will be available at `https://localhost:8043`. You can inspect the logs directly in your terminal.

### Manual Build (Alternative)

If you prefer to build manually, ensure you provide the required build arguments:

```bash
# Build from the repository root
docker build \
  --build-arg BUILD_ARCH=amd64 \
  --build-arg INSTALL_VER=6.0.0.23 \
  -t omada-dev:local \
  "Omada Dev"
```

Refer to the
[Home Assistant Add-On Testing Documentation](https://developers.home-assistant.io/docs/add-ons/testing)
for more details on how to test within a full Home Assistant environment.

### Releasing a New Version

1. Update the version in `config.yaml` for the relevant variant(s).
   Ensure the version matches one listed in
   [this script](https://github.com/mbentley/docker-omada-controller-url/blob/master/omada_ver_to_url.sh).
   If it is needed to make a new add-on release for the same Omada version,
   a `-ha{d}` suffix can be added to the Omada version.
   - When releasing a new Omada version, update both `Omada Stable v6` and `Omada Stable v6 (HA OS)`
     to keep them in sync.
2. Thoroughly test the changes in a local environment.
   Once the tests pass and you're satisfied, create a pull request (PR) with the updates.
3. The pipeline will build docker images for every branch,
   but only push the images to the registry on `master`.

## Contribution

This add-on was originally inspired by Matt Bentley’s
[docker-omada-controller](https://github.com/mbentley/docker-omada-controller).
Special thanks to contributors for advancing this project.
This add-on was made possible thanks to their outstanding work.

Key differences from the original:

- Persistent data is stored in the `/data` directory, making it compatible with Home Assistant.
- Managed via S6-Overlay for Home Assistant compatibility.

Contributions are welcome! Feel free to submit pull requests for version updates, bug fixes, or new features.

<a href="https://github.com/jkunczik/home-assistant-omada/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=jkunczik/home-assistant-omada" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
