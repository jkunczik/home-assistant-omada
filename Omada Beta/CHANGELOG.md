# Changelog

## 5.14.7 - 2024-11-10

- Fix SSL configuration and upgrade to 5.14.32.3

## 5.15.14.32.2 - 2024-09-5
### WARNING BREAKIN CHANGES PLEASE BACKUP YOUR OMADA CONFIGURATION TO RESTORE IT AFTER THIS UPDATE
- Updated to the upstream version 5.14.32.2
- fully merged all files (`install.sh`, `entrypoint.sh`, `Dockerfile`)
- only storing essential data (`data` and `lgos`) in the persistent `/data` volume

## 5.14.7 - 2024-09-5
### Changed
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
### Added
- Updated to 5.9.31 image


## 5.9.1 - 2023-03-11
### Added
- Experimental support for AMD64 platforms.
