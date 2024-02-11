--[[

ModHelper (Weezls Mod Lib for FS22) - Simplifies the creation of script based mods for FS22

This utility class acts as a wrapper for Farming Simulator script based mods. It hels with setting up the mod up and 
acting as a "bootstrapper" for the main mod class/table. It also add additional utility functions for sourcing additonal files, 
manage user settings, assist debugging etc.

See ModHelper.md (search my GitHub page for it since Giants won't allow "links" in the scripts) for documentation and more details.

Author:     w33zl (https://github.com/w33zl)
Version:    2.2.0
Modified:   2023-08-07

Changelog:
v2.0        FS22 version
v1.0        Initial public release

License:    CC BY-NC-SA 4.0
This license allows reusers to distribute, remix, adapt, and build upon the material in any medium or 
format for noncommercial purposes only, and only so long as attribution is given to the creator.
If you remix, adapt, or build upon the material, you must license the modified material under identical terms. 

]]



--[[

USAGE:

YourModName = Mod:init()

-- Logging and debugging (don't forget to add 'scripts/ModLib/LogHelper.lua' to <extraSourceFiles>)
--* debug(), var() and trace() will only print anything in the log if the file 'scripts/ModLib/DebugHelper.lua' is in your mod folder/zip archive
Log:debug("This is a debug message")
Log:var("name", "value")
Log:trace("This is a trace message")
Log:info("This is an info message")
Log:warning("This is a warning message")
Log:error("This is an error message")

-- Events
function YourModName:beforeLoadMap() end -- Super early event, caution!
function YourModName:loadMap(filename) end -- Executed when the map has finished loading, a good place to begin your mod initialization
function YourModName:beforeStartMission() end -- When user selects "Start" (but as early as possible in that event chain)
function YourModName:startMission() end -- When user selects "Start"
function YourModName:update(dt) end -- Looped as long game is running (CAUTION! Can severely impact performance if not used properly)

]]



-- This will create the "Mod" base class (and effectively reset any previous references to other mods) 
Mod = {

    getIsMultiplayer = function(self) return g_currentMission.missionDynamicInfo.isMultiplayer end,
    getIsServer = function(self) return g_currentMission.getIsServer() end,
    getIsClient = function(self) return g_currentMission.getIsClient() end,
    getIsDedicatedServer = function(self) return not self:getIsClient() and self:getIsServer() end, --g_dedicatedServer
    getIsMasterUser = function(self) return g_currentMission.isMasterUser end,
    getHasFarmAdminAccess = function(self) return g_currentMission:getHasPlayerPermission("farmManager") end,
    getIsValidFarmManager = function(self) return g_currentMission.player ~= nil and self:getHasFarmAdminAccess() and g_currentMission.player.farmId ~= FarmManager.SPECTATOR_FARM_ID end,
}
Mod_MT = {
}



local function getTrueGlobalG()
    return getmetatable(_G).__index
end

-- Store temporary global g_current* vars in the local scope of ModWrapper
local g_currentModDirectory = g_currentModDirectory
local g_currentModSettingsDirectory = g_currentModSettingsDirectory
local g_currentModName = g_currentModName

-- Set initial global values for the global ModWraper object/"class"
Mod.dir = g_currentModDirectory
Mod.settingsDir = g_currentModSettingsDirectory
Mod.name = g_currentModName
Mod.mod = g_modManager:getModByName(Mod.name)
Mod.env = getfenv()
Mod.__g = getTrueGlobalG() --getfenv(0)  --NOTE: WARNING: USE WITH CAUTION!!
Mod.globalEnv = Mod.__g

-- Wrapper to copy the global (but temporary) g_current* vars into the mod's environment
Mod.env.g_currentModSettingsDirectory = Mod.settingsDir
Mod.env.g_currentModName = Mod.name
Mod.env.g_currentModDirectory = Mod.dir



local modDescXML = loadXMLFile("modDesc", Mod.dir .. "modDesc.xml");
Mod.title = getXMLString(modDescXML, "modDesc.title.en");
Mod.author = getXMLString(modDescXML, "modDesc.author");
Mod.version = getXMLString(modDescXML, "modDesc.version");
-- Mod.author = Mod.mod.author
-- Mod.version = Mod.mod.version
delete(modDescXML);



-- Helper functions
local function validateParam(value, typeName, message)
    local failed = false
    failed = failed or (value == nil)
    failed = failed or (typeName ~= nil and type(value) ~= typeName)
    failed = failed or (type(value) == string and value == "")

    if failed then print(message) end

    return not failed
end




function Mod:source(file)
    source(self.dir .. file);
    return self; -- Return self to keep the "chain" (fluent)
end--function

function Mod:trySource(file, silentFail)
    local filename = self.dir .. file

    silentFail = silentFail or false

    if fileExists(filename) then
        source(filename);
    elseif not silentFail then
        self:printWarning("Failed to load sourcefile '" .. filename .. "'")
    end
    return self; -- Return self to keep the "chain" (fluent)
end--function

function Mod:init()
    local newMod = self:new();

    addModEventListener(newMod);

    print(string.format("Load mod: %s (v%s) by %s", newMod.title, newMod.version, newMod.author))

    return newMod;
end--function


function Mod:loadSound(name, fileName)
    local newSound = createSample(name)
    loadSample(newSound, self.dir .. fileName, false)
    return newSound
end

function Mod:new()
    local newMod = {}

    setmetatable(newMod, self)
    self.__index = self

    newMod.dir = g_currentModDirectory;
    newMod.name = g_currentModName


    local modDescXML = loadXMLFile("modDesc", newMod.dir .. "modDesc.xml");
    newMod.title = getXMLString(modDescXML, "modDesc.title.en");
    newMod.author = getXMLString(modDescXML, "modDesc.author");
    newMod.version = getXMLString(modDescXML, "modDesc.version");
    delete(modDescXML);

    -- newMod.startMission = function() end -- Dummy function/event

    -- FSBaseMission.onStartMission = Utils.appendedFunction(FSBaseMission.onStartMission, function(...)
    --     newMod.startMission(newMod, ...)
    -- end);

    FSBaseMission.onStartMission = Utils.appendedFunction(FSBaseMission.onStartMission, function(baseMission, ...) 
        if newMod.startMission ~= nil and type(newMod.startMission) == "function" then
            newMod:startMission(baseMission, ...)
        end
    end)

    FSBaseMission.onStartMission = Utils.prependedFunction(FSBaseMission.onStartMission, function(baseMission, ...) 
        if newMod.beforeStartMission ~= nil and type(newMod.beforeStartMission) == "function" then
            newMod:beforeStartMission(baseMission, ...)
        end
    end)

    -- Mission00.loadMission00Finished = Utils.appendedFunction(Mission00.loadMission00Finished, function(mission00, ...) 
    --     if newMod.missionLoaded ~= nil and type(newMod.missionLoaded) == "function" then
    --         newMod:missionLoaded(mission00, ...)
    --     end
    -- end)

    FSBaseMission.load = Utils.appendedFunction(FSBaseMission.load, function(baseMission, ...) 
        if newMod.load ~= nil and type(newMod.load) == "function" then
            newMod:load(baseMission, ...)
        end
    end)


    FSBaseMission.initialize = Utils.appendedFunction(FSBaseMission.initialize, function(baseMission, ...) 
        if newMod.initMission ~= nil and type(newMod.initMission) == "function" then
            newMod:initMission(baseMission, ...)
        end
    end)

    FSBaseMission.loadMap = Utils.prependedFunction(FSBaseMission.loadMap, function(baseMission, ...) 
        if newMod.beforeLoadMap ~= nil and type(newMod.beforeLoadMap) == "function" then
            newMod:beforeLoadMap(baseMission, ...)
        end
    end)

    FSBaseMission.loadMap = Utils.appendedFunction(FSBaseMission.loadMap, function(baseMission, ...) 
        if newMod.afterLoadMap ~= nil and type(newMod.afterLoadMap) == "function" then
            newMod:afterLoadMap(baseMission, ...)
        end
    end)


    FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, function(baseMission, ...) 
        if newMod.loadMapFinished ~= nil and type(newMod.loadMapFinished) == "function" then
            newMod:loadMapFinished(baseMission, ...)
        end
    end)

    FSBaseMission.loadMapFinished = Utils.appendedFunction(FSBaseMission.loadMapFinished, function(baseMission, ...) 
        if newMod.afterLoadMapFinished ~= nil and type(newMod.afterLoadMapFinished) == "function" then
            newMod:afterLoadMapFinished(baseMission, ...)
        end
    end)

    FSBaseMission.onMinuteChanged = Utils.appendedFunction(FSBaseMission.onMinuteChanged, function(baseMission, ...)
        if newMod.onMinuteChanged ~= nil and type(newMod.onMinuteChanged) == "function" then
            newMod:onMinuteChanged(baseMission, ...)
        end
    end)

    FSBaseMission.onHourChanged = Utils.appendedFunction(FSBaseMission.onHourChanged, function(baseMission, ...)
        if newMod.onHourChanged ~= nil and type(newMod.onHourChanged) == "function" then
            newMod:onHourChanged(baseMission, ...)
        end
    end)

    FSBaseMission.onDayChanged = Utils.appendedFunction(FSBaseMission.onDayChanged, function(baseMission, ...)
        if newMod.onDayChanged ~= nil and type(newMod.onDayChanged) == "function" then
            newMod:onDayChanged(baseMission, ...)
        end
    end)

    return newMod;
end--function


