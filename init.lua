-- mods/australia/init.lua

-- MOD: australia
-- See README.md for licensing and other information.
-- Designed for valleys mapgen in Minetest 0.4.14, but will work with mgv5,
-- mgv7, flat and fractal with limitations.

-- Check for necessary mod functions and abort if they aren't available.
if not minetest.get_biome_id then
	minetest.log()
	minetest.log("* Not loading MOD: Australia *")
	minetest.log("MOD: Australia requires mod functions which are")
	minetest.log(" not exposed by your Minetest build.")
	minetest.log()
	return
end

-- Definitions made by this mod that other mods can use too
aus = {}
aus.path = minetest.get_modpath("australia")
aus.schematics = {}


-- Load files
dofile(aus.path .. "/functions.lua")
dofile(aus.path .. "/nodes.lua")
dofile(aus.path .. "/noairblocks.lua")
dofile(aus.path .. "/craftitems.lua")
dofile(aus.path .. "/crafting.lua")
dofile(aus.path .. "/trees.lua")
dofile(aus.path .. "/mapgen.lua")
dofile(aus.path .. "/saplings.lua")
--dofile(aus.path .. "/voxel.lua")

minetest.log("MOD: Australia loaded")
