# ModHelper


###


## BASIC USAGE

```lua
-- Creates a new mod object (listening to mod events such as loadMap etc)
YourModName = Mod:init()

-- Executed when the map has finished loading, a good place to begin your mod initialization
function YourModName:loadMap(filename) 
  print("Map is loaded")
end 
```

## IMPORTANT INFORMATION
When you are using `Mod:init()` to initialize your mod, the following global variables are persisted (they are normally nil:ed before your mod is loaded).

```lua
g_currentModSettingsDirectory
g_currentModName
g_currentModDirectory
```

This means you **no longer need** to do the "local variable hack" at the beginning of your script:
```lua
local g_currentModSettingsDirectory = g_currentModSettingsDirectory
local g_currentModName = g_currentModName
local g_currentModDirectory = g_currentModDirectory
```

You can also access these values anywhere you can access your mod object, this could be useful if you expose your mod in `g_globalMods` and someone want to know the name or directory of your global mod:
```lua
print(YourMod.settingsDir) -- same as g_currentModSettingsDirectory
print(YourMod.name) -- same as g_currentModName
print(YourMod.dir) -- same as g_currentModDirectory

print(g_globalMods.AnotherGlobalMod.name) -- prints the name of the AnotherGlobalMod and is -not- the same as g_currentModName
```

## SCRIPT REFERENCE

| Function/Field | _Description_ |
|-|-|
|||
| **_Functions_** ||
|init()| Initializes a new mod object, executing `addModEventListener` and set some default values |
| getIsMultiplayer() | QoL wrapper to check if game is in multiplayer mode |
| getIsServer() | QoL wrapper to check if the current game instance is a server |
| getIsClient() | QoL wrapper to check if the current game instance is a client |
| getIsDedicatedServer () | QoL wrapper to check if the current game instance is a dedicated server |
| getIsMasterUser() | QoL wrapper to check if the current user is a master user |
| getIsValidFarmManager() | QoL wrapper to check if the current user has farm manager access |
| source(relativePath) | QoL wrapper for the base game source function, however this will automatically add the mod directory at the beginning of the path (e.g `MyMod:source("MyFile.lua")` is valid) |
| trySource(relativePath, silentFail) | Same as `source`, however this one first checks if the file actually exists and only prints a warning if the file doesn't exists (or nothing if `silentFail` is true) |
| loadSound(name, fileName) | QoL function to load sounds, wrapper for `createSample(name)` and `loadSample` with `fileName` as parameter |
|||
| **_Events** ||
|beforeStartMission()| Event that is fired before `FSBaseMission.onStartMission` |
|beforeStartMission()| Event that is fired after `FSBaseMission.onStartMission` |
|load()| Event that is fired after `FSBaseMission.load` |
|initMission()| Event that is fired after `FSBaseMission.initialize` |
|beforeLoadMap()| Event that is fired before `FSBaseMission.loadMap` |
|afterLoadMap()| Event that is fired after `FSBaseMission.loadMap` |
|afterLoadMapFinished()| Event that is fired after `FSBaseMission.loadMapFinished` |
|onDayChanged()| Event that is fired after `FSBaseMission.onDayChanged` |
|onHourChanged()| Event that is fired after `FSBaseMission.onHourChanged` |
|onMinuteChanged()| Event that is fired after `FSBaseMission.onMinuteChanged` |
|||
| **_Fields_** ||
| dir | Mod directory (same as `g_currentModDirectory`) |
| settingsDir | Mod settings directory, i.e. your `Documents\My Games\FarmingSimulator2022\modSettings\[YOUR_MOD_NAME]\` folder (same as `g_currentModSettingsDirectory`) |
| name | The name of the mod (same as `g_currentModName`) |
| mod | The mod metadata object, i.e. not the current object you created but the object containing all the information from the modDesc file |
| env | The mod environment, i.e. the "global scope" of your mod sandbox (shared between all files in your mod, but not accessible from other mods), same as `getfenv()` |
| title | The mod title from the modDesc |
| author | The author information from the modDesc |
| version| The mod version from the modDesc |
|||