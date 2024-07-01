# ScriptLibrary

This is the main file for the FS Script Library and is mandatory.

###


## BASIC USAGE

The FS Script Library is activated by adding this to your modDesc.xml file:

```xml
<extraSourceFiles>
    <sourceFile filename="scripts/scriptLibrary/scriptLibrary.lua" />
</extraSourceFiles>`
```

## THE CONTENTS OF THE SCRIPT FILE
This script contains three sections:

### 1. Initialization of the Script Library path

```lua
_G.g_scriptLibraryDir = g_currentModDirectory .. "scripts/scriptLibrary/"
```

_**Note:** It is possible to place the Script Library in another folder than the default location, however if doing so you need to change the path `"scripts/scriptLibrary/"` to the new location._


### 2. Sourcing of core script files
The following section loads the core files and is recommended to keep enabled.

```lua
-- Core libraries
source(g_scriptLibraryDir .. "ModHelper.lua") -- Recommended for all mods, enables the Mod:init() wrapper to create the mod object
```

### 3. Sorucing of optional script files
This section of the scriptLibrary.lua sources all the optional scripts. Enable those that you intend to use. They can all be enabled without any harm, however to keep the Lua memory as clean as possible it is recommended to only enable the files you are actually using.

```lua
-- Specializations
-- source(g_scriptLibraryDir .. "")

-- Base Game Class Extensions
-- source(g_scriptLibraryDir .. "")

...
```
