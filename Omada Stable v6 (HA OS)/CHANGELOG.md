# Changelog

## 6.2.10.17

- Initial release of the HA OS variant.
- Uses MongoDB 7.0 (Ubuntu 22.04 base) to avoid tcmalloc `MmapAligned()` failures
  that occur when running MongoDB 8.0 inside HA OS containers on ARM64 hardware (e.g. Raspberry Pi 5).
