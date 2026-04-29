# Changelog

## Version release 6.2.10.17 2026-04-30

- Updated to Omada version 6.2.10.17

## Version release 6.2.0.17 2026-04-02

- Updated to Omada version 6.2.0.17

## 6.1.0.19-ha1 2026-01-31

- **Architecture Overhaul:**
  - Complete refactor to use native Home Assistant S6 overlay v3 service supervision.
  - Removed dependency on `mbentley` upstream submodule.
  - Improved process management and reliability.
- **New Features:**
  - Added `show_mongodb_logs` option to debug internal database issues.
  - Added `show_server_logs` option (enabled by default) to control server log verbosity.
  - **Networking:** Enabled `host_network: true` by default to improve device discovery and simplify port management.
- **Fixes & Improvements:**
  - Optimized startup time by checking permissions before applying them.
  - Fixed `UnsatisfiedDependencyException` during boot.
- Add stop_timeout of 60 seconds and S6_SERVICES_GRACETIME for graceful MongoDB shutdown,
  this might be needed for hardware with limited resources.

## Version release 6.1.0.19 2026-01-21

- Updated to Omada version 6.1.0.19
  - `WARNING` v6 is a major version please read previous release notes if upgrading from v5

## Major Version release 6.0.0.25 2025-12-04

- First Omada Controller version 6 release
  - This is a completely separate installation from the old Stable branch
  - To migrate, please make a back up from the old Stable branch and import it here.
  - This new version 6 no longer works on a Raspberry Pi 4, due to the new Mongo DB version being not campatible with that instruction set.
