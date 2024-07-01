# ⚙️FS Script Library
The unofficial extension to the base game Lua library, adding new features and quality-of-life helper libraries, making this your one-stop-shop and starting point for all your mods. 

With a non-intrusive opt-in approach running in the mod sandbox you can safely add this to any mod without any risk of version conflicts or bloating your mod. You choose what features to enable and to what extent you want to utilize the library.

If you have any suggestions, find an issue or maybe even have your own nifty functions you want to share with others, we gladly accept your contribution (see the [Contribute](https://github.com/open-modding-alliance#-want-to-contribute) section below for options and details).

###

**_Quick links:_ [Installation](https://github.com/open-modding-alliance/ScriptLibrary?tab=readme-ov-file#installation) | [Getting Started](https://github.com/open-modding-alliance/ScriptLibrary?tab=readme-ov-file#getting-started) | [Script Reference](https://github.com/open-modding-alliance/ScriptLibrary?tab=readme-ov-file#reference)**


## INSTALLATION
To install the FS Script Library you have three options:

### A. Get The Bootstrap Mod
The quickest way to get started with a new mod is the [Bootstrap Mod](https://github.com/open-modding-alliance/BootstrapMod) that is the foundation for a complete ready-to-run mod with _FS Script Library_ already installed. 

To add script library to an existing mod, the automatic (B) or manual installation (C) is recommended.



### B. Automatic Installation _[DISABLED]_
<!--Run the script below via the command line in the root of your mod folder (e.g. '%UserProfile%/Documents/FarmingSimulator2022/mods/MyMods'):
```bash
curl -s http://myscript.com/download.bat | cmd
```
_**IMPORTANT**! Never trust code you download from the internet, please review the contents of the script above (URL) if you are not certain about the content._
-->

### C. Manual Installation

1. Download the latest archive
2. Unzip the zip archive to the root of your mod folder, it should look like this:
  ```
  yourMod\
    scripts\
      scriptLibrary\
        ...
        scriptLibrary.lua
        ModHelper.lua
    YourMod.lua
  ```
3. Follow the instructions in the [Getting Started](https://github.com/open-modding-alliance/BootstrapMod) section.

## GETTING STARTED

**1. Install FS Script Library to your mod**

**2. Add the _scriptLibrary.lua_ file to the _&lt;extraSourceFiles&gt;_ section of your _modDesc.xml_:**

```xml
<extraSourceFiles>
    <sourceFile filename="scripts/scriptLibrary/scriptLibrary.lua" />
</extraSourceFiles>`
```

**3. Uncomment the files you want to include from the _scriptLibrary.lua_ file, e.g:**

```lua
-- ### Specializations (disabled by default) ###
source(g_scriptLibraryDir .. "defaultDisabled.lua")
--source(g_scriptLibraryDir .. "alsoDisabledByDefault.lua")
```

**4. Create your main mod script file (e.g. MyMod.lua) and add it to the _&lt;extraSourceFiles&gt;_ section of your _modDesc.xml_**
   
**5. _[optional]_ Add the following snippet to your main mod script file:**

```lua
-- Creates a new mod object (listening to mod events such as loadMap etc)
YourModName = Mod:init()

-- Executed when the map has finished loading, a good place to begin your mod initialization
function YourModName:loadMap(filename) 
  print("Map is loaded")
end 
```

**6. Try your mod**
 
_**Note:** Using the `Mod` helper class in step 5 is optional, you can create the mod however you like, this is just the quick and easy way to get started._



## REFERENCE

| _Folder_ | _File (.lua)_ | _Description_ |
|-|-|-|
|_(no folder)_|||
||[scriptLibrary](docs/ScriptLibrary.md) | This is the main script for the FS Script Library, this file contains a reference to all possible other files, uncomment the files you want to include. |
|| [ModHelper](docs/ModHelper.md) | QoL wrapper and helper library to create your script mod, this serves as a good starting point for all mods, see documentation for all available functions and properties provided by the helper class. |
||||
| **ui** || **UI/HUD related scripts** |
||||
| **placeables** || **Classes and utility scripts related to placeables** |
||||
| **specializations** || **Vehicle and placeable specializations** |
||||
| **extensions** || **General extension to base game classes** |
||||
| **utils** || **Helpers classes, e.g. to extend the string class or utilities for debugging** |
||||
| **misc**||**Other scripts not matching any of the above categories**|
||||

<!--


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


-->