_G.g_scriptLibraryDir = g_currentModDirectory .. "scripts/scriptLibrary/"

-- Generic libraries
source(g_scriptLibraryDir .. "ModHelper.lua") -- Recommended for all mods, enables the Mod:init() wrapper to create the mod object

-- Specializations
-- source(g_scriptLibraryDir .. "")

-- Base Game Class Extensions
-- source(g_scriptLibraryDir .. "")