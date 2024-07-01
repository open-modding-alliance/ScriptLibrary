--[[

FS Script Library - A collection of utility/helper classes for Farming Simulator mods

Author(s):  Open Modding Alliance (w33zl)
Version:    1.0.0

License:    CC BY-NC-SA 4.0
This license allows reusers to distribute, remix, adapt, and build upon the material in any medium or 
format for noncommercial purposes only, and only so long as attribution is given to the creator.
If you remix, adapt, or build upon the material, you must license the modified material under identical terms. 


USAGE:

    Add the following to your modDesc.xml file:
    <extraSourceFiles>
        <sourceFile filename="scripts/scriptLibrary/scriptLibrary.lua" />
    </extraSourceFiles>`

]]

_G.g_scriptLibraryDir = g_currentModDirectory .. "scripts/scriptLibrary/"

-- ### Core libraries (recommended) ###
source(g_scriptLibraryDir .. "ModHelper.lua") -- Recommended for all mods, enables the Mod:init() wrapper to create the mod object

-- ### Additional libraries (optional) ###


-- *** Specializations ***
-- source(g_scriptLibraryDir .. "")

-- Base Game Class Extensions
-- source(g_scriptLibraryDir .. "")