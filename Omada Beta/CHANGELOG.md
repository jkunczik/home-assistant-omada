# Changelog

## beta-5.15.24.14 2025-05-15

- Updated to Omada version beta-5.15.24.14

## beta-5.15.20.16 2025-03-20

- Updated to Omada version beta-5.15.20.16

## beta-5.15.20.12 2025-02-28

- Updated to Omada version beta-5.15.20.12

## beta-5.15.20.10 2025-01-25

- Updated to Omada version beta-5.15.20.10

## beta-5.15.8.2-ha2 2025-01-8

- Fix workaround 509 option being unavailable in the home assistant interface.

## beta-5.15.8.2-ha1 2025-01-8

- Add option to use workaround 509 from `mbentley`.
- This also solves the bug that Omada does not start when it has not been set. #73
- Omada is still on the same version: beta-5.15.8.2

## beta-5.15.8.2 2025-01-7

- Updated to Omada version beta-5.15.8.2

## beta-5.15.8.1 2024-12-24

- Updated to Omada version beta-5.15.8.1

## 5.15.6.7 2024-12-12

- Updated to Omada version pre-release 5.15.6.7

## beta-5.15.6.4 2024-11-16

- `WARNING` slug has changed.
  This will make it look like the repository disappeared in HA.
  Please export your configuration and import it again in a new installation.
- Restructured the repostory, mbentley is now a submodule
- Implemented pipeline
- Updated to the upstream version beta-5.15.6.4

## 5.14.32.3 - 2024-11-10

- Upgrade to 5.14.32.3
- Fix SSL configuration
- Fix restoring backup old file structure. Manual backup no longer needed.

## 5.14.32.2 - 2024-09-5

- Updated to the upstream version 5.14.32.2
- fully merged all files (`install.sh`, `entrypoint.sh`, `Dockerfile`)
- only storing essential data (`data` and `logs`) in the persistent `/data` volume

## 5.14.7 - 2024-09-5

- Updated to the upstream version 5.14.30.7

## 5.13.300 - 2023-03-28

- Clean up Dockerfile and scripts
- Fix to make log files persistent

## 5.13.30 - 2023-03-27

- Support for using the SSL certificate from Home Assistant in Omada

## 5.13.3 - 2023-08-31

- Version bump to latest Omada Beta

## 5.9.3 - 2023-08-31

-Fix for the healthcheck Thanks nathanielks!

## 5.9.2 - 2023-04-3

- Updated to 5.9.31 image

## 5.9.1 - 2023-03-11

- Experimental support for AMD64 platforms.
