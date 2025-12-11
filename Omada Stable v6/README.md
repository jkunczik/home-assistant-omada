# Home Assistant Omada Add-On v6

This add-on brings the Omada Controller v6 directly into Home Assistant running on an ARM, x64 or x86 processor.
Version 6 no longer works on a Raspberry Pi 4 due to the new Mongo DB version being not compatible with that instruction set.

## Contribution

This add-on is a fork of Matt Bentleys
[docker-omada-controller](https://github.com/mbentley/docker-omada-controller)
and jkunczik [home-assistant-omada](https://github.com/jkunczik/home-assistant-omada)
would not have been possible without their excellent work.
Other than in the original docker omada controller,
this add-on stores all persistent data in the /data directory,
so that it is compatible with Home Assistant.
This Add-On would not be possible without the effort of other people.
Pull requests for version updates or new features are always more than welcome.
Special thanks goes to DraTrav for pushing this Add-On forward!
