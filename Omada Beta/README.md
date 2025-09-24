# Home Assistant Omada Add-On Beta

This add-on brings the Omada Controller directly into Home Assistant running on an 64 bit ARM or a x64 processor.

Omada Beta contains the most recent port of the
[docker-omada-controller](https://github.com/mbentley/docker-omada-controller).
If you need a more recent version, open an issue, or better submit a pull request.

For upgrade from v5 to v6 please read the notes on [docker-omada-controller](https://github.com/mbentley/docker-omada-controller).

## Contribution

This add-on is a fork of Matt Bentleys
[docker-omada-controller](https://github.com/mbentley/docker-omada-controller),
and jkunczik [home-assistant-omada](https://github.com/jkunczik/home-assistant-omada)
would not have been possible without their excellent work.
Other than in the original docker omada controller,
this add-on stores all persistent data in the /data directory,
so that it is compatible with Home assistant.
This Add-On would not be possible without the effort of other people.
Pull requests for version updates or new features are always more than welcome.
Special thanks goes to DraTrav for pushing this Add-On forward!
