# Changelog

## Major Version release 6.0.0.25 2025-12-04
WARNING This is a major version upgrade!
Version 6.0.0.25 needs a clean install from scratch, since the MongoDB database had a major version bump.
Please backup your settings with export function on the https://<ip-address-or-hostname>:8043/#maintenance page first.
Then uninstall the Add-On, and choose the option to permanantly remove persistent data.
Now perform a new install of Add-On.
Updated to Omada version 6.0.0.25
Use a new Ubuntu 24.04 base image. (This is needed for the new MongoDB 8.x version).
Update mbently submodule to adopt new version 6 changes.
Add healthcheck for Watchdog functionality.

## 5.15.24.19 2025-08-02

- Updated to Omada release 5.15.24.19

## 5.15.24.18 2025-07-03

- Updated to Omada release 5.15.24.18

## 5.15.20.20 2025-04-29

- Updated to Omada release 5.15.20.20

## 5.15.20.18 2025-03-01

- Updated to Omada release 5.15.20.18

## 5.15.8.2 2025-01-14

- Updated to Omada release 5.15.8.2

## 5.15.6.7-ha1 2025-1-8

- Added extra configuration option to enable workaround 509 from `mbentley`.
  - Only try to enable this if you run into startup issues.
- Omada is still at 5.15.6.7. When this new option is not enabled, nothing changes.

## 5.15.6.7 2024-12-27

- Updated to Omada release 5.15.6.7

## 5.14.32.4 2024-11-16

- Restructured the repostory, mbentley is now a submodule
- Implemented pipeline
- Updated to the upstream version 5.14.32.4

## 5.14.7 - 2024-09-5

- Updated to the upstream version 5.14.30.7

## 5.14.1 - 2024-01-15

- Updated to the upstream version 5.14

## 5.13.300 - 2023-03-28

- Clean up Dockerfile and scripts
- Fix to make log files persistent

## 5.13.30 - 2023-03-27

- Support for using the SSL certificate from Home Assistant in Omada

## 5.13.3 - 2023-08-31

- Version bump to latest Omada Beta

## 5.9.3 - 2023-08-31

- Fix for the healthcheck Thanks nathanielks!

## 5.9.2 - 2023-04-3

- Updated to 5.9.31 image

## 5.9.1 - 2023-03-11

- Experimental support for AMD64 platforms.
