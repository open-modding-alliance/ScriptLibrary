# FS Script Library
The unofficial extension to the base game Lua library, adding new features and quality-of-life helper libraries, making this your one-stop-shop and starting point for all your mods. 

With a non-intrusive opt-in approach running in the mod sandbox you can safely add this to any mod without any risk of version conflicts or bloating your mod. You choose what features to enable and to what extent you want to utilize the library.

If you have any suggestions, find an issue or maybe even have your own nifty functions you want to share with others, we gladly accept your contribution (see the [Contribute](https://github.com/open-modding-alliance#-want-to-contribute) section below for options and details).

## INSTALLATION
To install the FS Script Library you have three options:

### A. Get The Bootstrap Mod
The quickest way to get started with a new mod is the Bootstrap Mod that is the foundation for a complete ready-to-run mod with _FS Script Library_ already installed. To add script library to an existing mod, the automatic or manual installation is recommended.



### B. Automatic Installation
Run the script below via the command line in the root of your mod folder (e.g. '%UserProfile%/Documents/FarmingSimulator2022/mods/MyMods'):
```bash
curl -s http://myscript.com/download.bat | cmd
```
_**IMPORTANT**! Never trust code you download from the internet, please review the contents of the script above (URL) if you are not certain about the content._


### C. Manual Installation

1. Download the latest archive
2. Unzip the zip archive to the root of your mod folder


## USAGE


## GETTING STARTED


## REFERENCE

| Folder|Description|
|-|-|
| ui|UI/HUD related scripts|
| placeables|Classes and utility scripts related to placeables|
| specializations|Vehicle and placeable specializations|
| extensions|General extension to base game classes|
| utils|Helpers classes, e.g. to extend the string class or utilities for debugging|
||
| **misc**|**Other scripts not matching any of the above categories**|
|[scriptLibrary](scripts/scriptLibrary/scriptLibrary.lua)|This is the main script for the FS Script Library, this file contains a reference to all possible other files, uncomment the files you want to include|
|[ModHelper](scripts/scriptLibrary/ModHelper.lua)|QoL wrapper and helper library to create your script mod, this serves as a good starting point for all mods|



| File|Description|
|-|-|
|[scriptLibrary](scripts/scriptLibrary/scriptLibrary.lua)|This is the main script for the FS Script Library, this file contains a reference to all possible other files, uncomment the files you want to include|
|[ModHelper](scripts/scriptLibrary/ModHelper.lua)|QoL wrapper and helper library to create your script mod, this serves as a good starting point for all mods|


### extensions
| File|Description|
|-|-|
|[ModHelper](https://link-url-here.org)|QoL wrapper and helper library to create your script mod|
|||



| _extensions_ |_General extension to base game classes_|
|-|-|
|[ModHelper](https://link-url-here.org)|QoL wrapper and helper library to create your script mod|
|||


