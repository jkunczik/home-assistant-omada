# Home Assistant Omada Add-On

![CI](https://github.com/jkunczik/home-assistant-omada/workflows/Build%20and%20Push%20Multi-Platform%20Docker%20Image/badge.svg)

This add-on brings the Omada Controller directly into Home Assistant running on an 64 bit ARM or a x64 processor.

There exist two Add-On-Versions:

- Omada Stable
- Omada Beta

Omada Stable is created from Omada Beta (both in this repository), as soon as the beta add-on is updated to the latest
stable upstream version. Omada Beta should also be fairly stable, because the Add-On is mostly consistent with the already tested [docker-omada-controller](https://github.com/mbentley/docker-omada-controller), but might contain some Home-Assistant related inconsistencies or bugs.

## Installation

Installing third-party repositories:

1. Go to home assistant -> settings -> addons -> addon store
2. Click the hamburger menu (The three dots in the top right corner)
3. Click repositories
4. At the bottom there should be a space to paste the GitHub link: https://github.com/jkunczik/home-assistant-omada
5. You might have to refresh the page, but it should show up in the addon store under "Home Assistant Omada"

## Options

If you would like to use your own SSL certificate configured for Home Assistant with this Omada Add-On,
it can be enabled in the configuration options.
Set `Enable Home Assistant SSL` to `true`, and enter the full path for:

- `Certificate file`
- `Private key`

The default paths are compatible with the `LetsEncrypt` Add-On.

## Release a new version

To update the controller to a new version, the following steps have to be done:

1. Upgrade the mbentley submodule to the latest on `master`.
2. Upgrade the version in `config.yaml` in either beta or stable.
This version should match exactly with one for the versions listed [here](https://github.com/mbentley/docker-omada-controller-url/blob/master/omada_ver_to_url.sh).
3. If everything is working as expected, you can create a new GitHub release.
The tag should match the version in the config.yaml exactly.
Otherwise the pipeline will fail.

## Contribution

This add-on is a fork of Matt Bentleys
[docker-omada-cotroller](https://github.com/mbentley/docker-omada-controller),
and jkunczik [home-assistant-omada](https://github.com/jkunczik/home-assistant-omada)
would not have been possible without their excellent work.
Other than in the original docker omada controller,
this add-on stores all persistent data in the /data directory,
so that it is compatible with Home assistant.
This Add-On would not be possible without the effort of other people.
Pull requests for version updates or new features are always more than welcome.
Special thanks goes to DraTrav for pushing this Add-On forward!

<a href="https://github.com/jkunczik/home-assistant-omada/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=jkunczik/home-assistant-omada" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
