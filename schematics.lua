-- mods/australia/schematics.lua
-- Was mods/australia/functions.lua

-- Create and initialize a table for a schematic.
function aus.schematic_array(width, height, depth)
	-- Dimensions of data array.
	local s = {size={x=width, y=height, z=depth}}
	s.data = {}

	for z = 0,depth-1 do
		for y = 0,height-1 do
			for x = 0,width-1 do
				local i = z*width*height + y*width + x + 1
				s.data[i] = {}
				s.data[i].name = "air"
				s.data[i].param1 = 000
			end
		end
	end

	s.yslice_prob = {}

	return s
end

local DIR_DELIM = "/"
local schempath = minetest.get_worldpath() .. DIR_DELIM .. "schems"
minetest.mkdir(schempath)

function TreeSchematic(name, min_r, max_r, ht, fruit,
		limbs, tree, leaves, trunk_height)

	local min_r = min_r
	local max_r = max_r
	local ht = ht
	local fruit = fruit
	local limbs = limbs
	local tree = tree
	local leaves = leaves

	-- Write the schematic back to a world schems directory for later loading.
	-- TODO: Not proven that disk cache is faster than runtime gen
	local function cacheMTS(idx)
		local schemdata = aus.schematics[name][idx]
		local filepath = schempath .. DIR_DELIM .. name .. "_" .. tostring(idx) .. ".mts"
		local file = io.open(filepath, "rb")
		local schem_mts

		if file == nil then
			schem_mts = minetest.serialize_schematic(schemdata, "mts", {})
			file = io.open(filepath, "wb")
			if file then
				local succ = file:write(schem_mts)
				if not succ then
					minetest.log("error", "Could not write to schematic : " .. filepath)
				end
				file:close()
			else
				minetest.log("error", "Could not open schematic: " .. filepath)
			end
		else
			-- Already exists, no-op
			file:close()
			schem_mts = minetest.read_schematic(filepath, {})
		end
	end

	-- Ensure the schematic exists
	local function ensure_schem()
		if aus.schematics[name] ~= nil then return end
		aus.schematics[name] = {}

		local idx = 1
		for r = min_r,max_r do
			local filepath = schempath .. DIR_DELIM .. name .. "_" .. tostring(idx) .. ".mts"
			local file = io.open(filepath, "rb")

			-- Read a cached file from world dir if it exists, else generate and
			-- save to cache.
			if file ~= nil then
				table.insert(aus.schematics[name],
					minetest.read_schematic(filepath, {}))
				assert(type(aus.schematics[name][idx]) == "table")
				file:close()
			else
				table.insert(aus.schematics[name],
					aus.generate_tree_schematic(trunk_height,
						{x=r, y=ht, z=r}--[[<-radii--]],
						tree, leaves, fruit, limbs))
				cacheMTS(idx)
			end
			idx = idx + 1
		end
	end

	-- Register the schematic to the biome using the decoration parameters.
	-- Do not pass the actual fill ratio but the divisor term 'k' so that the equation:
	-- fill_ratio = (max_r-r+1)/k
	-- works as intended
	local function register_to_biome(biome_name, decoparams)
		local r
		for idx, schem in pairs(aus.schematics[name]) do
			-- index and radius are a fixed amount apart so we can reconstruct r
			r = idx + (min_r-1)
			minetest.register_decoration({
				deco_type = "schematic",
				sidelen = 80,
				place_on = decoparams.place_on,
				y_min = decoparams.y_min,
				y_max = decoparams.y_max,
				fill_ratio = (max_r-r+1)/decoparams.fill_ratio,
				biomes = {biome_name},
				schematic = schem,
				flags = "place_center_x, place_center_z",
				rotation = "random",
			})
		end
	end

	return {
		ensure_schem = ensure_schem,
		register_to_biome = register_to_biome,
		cacheMTS = cacheMTS,
	}
end

aus.schematics_cache = {}

-- TODO: Cache TreeSchematic etc. objects to avoid multiple instatiation - remove cache
-- after init.
function aus.register_schem_to_biome(name, biome, decoparams)
	if aus.schematics_cache[name] == nil then
		local schem_lua = minetest.get_modpath("australia")
				.. DIR_DELIM .. "schematics" .. DIR_DELIM .. name .. ".lua"
		aus.schematics_cache[name] = dofile(schem_lua)
	end

	local schem = aus.schematics_cache[name]
	schem.ensure_schem()
	schem.register_to_biome(biome, decoparams)
end

-- The *Schematic objects are not needed after init as the schematic live inside
-- Minetest.
function aus.clear_schem_cache()
	aus.schematics_cache = nil
end
