-- mods/australia/init.lua

-- MOD: australia
-- See README.md for licensing and other information.
-- Originally designed for valleys mapgen in Minetest 0.4.14, but would work
-- with mgv5, mgv7, flat and fractal with limitations.
-- Aussieforks version now designed for carpathian mapgen in Minetest 5.6.0, 
-- but will work with others as well.

--[[ This code is disabled while voxel.lua remains disabled because it serves no
     purpose in that case, and interferes with mineunit.
-- Check for necessary mod functions and abort if they aren't available.
if not minetest.get_biome_id then
	minetest.log("error", "* Not loading MOD: Australia *")
	minetest.log("error", "MOD: Australia requires mod functions which are")
	minetest.log("error", " not exposed by your Minetest build.")
	return
end
--]]

-- Definitions made by this mod that other mods can use too
aus = {}
aus.path = minetest.get_modpath("australia")
aus.schematics = {}

aus.debug_mode = minetest.settings:get_bool("australia.debug_mode", false)
if aus.debug_mode then
	minetest.log("info", "[australia] Loading in debug mode")
end


-- Load files
dofile(aus.path .. "/functions.lua")
dofile(aus.path .. "/tree_gen.lua")
dofile(aus.path .. "/nulda.lua")
dofile(aus.path .. "/schematics.lua")
dofile(aus.path .. "/schematics_commands.lua")
dofile(aus.path .. "/decorations.lua")
dofile(aus.path .. "/mapgen.lua")
dofile(aus.path .. "/saplings.lua")
dofile(aus.path .. "/nodes.lua")
dofile(aus.path .. "/craftitems.lua")
dofile(aus.path .. "/crafting.lua")
--dofile(aus.path .. "/voxel.lua")

-- Clear schematic-generating objects that are no longer needed
aus.clear_schem_cache()

minetest.log("MOD: Australia loaded")
