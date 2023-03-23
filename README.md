# Home Assistant Omada Add-On
This add-on brings the Omada Controller directly into Home Assistant running on a Raspberry Pi. 

The stable version is based on omada v5.0, while the current beta is at version 5.9. The beta channel has now experimental support for AMD64 systes. Feedback is welcome!

# About this Add-On
This add-on is a fork of Matt Bentleys [docker-omada-cotroller](https://github.com/mbentley/docker-omada-controller)  would not have been possible without his excellent work. Other than in the original docker omada controller, this add-on stores all persistent data in the /data directory, so that it is compatible with Home assistant.

# How to install
1. In Home Assistant navigate to *Settings -> Add-Ons -> Add-On Store* (bottom left corner)
2. Click the dot menu at the top right corner and select *Repositories*
3. Past the following link into the text box: https://github.com/jkunczik/home-assistant-omada, then click *ADD*
4. After you refresh the page the Stable and the Beta Add-On should appear in the section *Home Assistant Omada*

# Contributors
Special thanks @DraTrav for restructuring and updating the repo.

<a href="https://github.com/jkunczik/home-assistant-omada/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=jkunczik/home-assistant-omada" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
