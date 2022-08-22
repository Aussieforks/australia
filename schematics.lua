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

-- Write the schematic back to a world schems directory for later loading.
-- TODO: Not proven that disk cache is faster than runtime gen
local function schematic_cacheMTS(self, idx)
	local name = self.name
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
		--schem_mts = minetest.read_schematic(filepath, {})
	end
end

-- Ensure the schematic exists
local function schematic_ensure_schem(self)
	local name = self.name
	if aus.schematics[name] ~= nil then return end
	aus.schematics[name] = {}

	-- Locals save multiple table lookup in theory
	local idx = 1
	local min_r = self.min_r
	local max_r = self.max_r
	local trunk_height = self.trunk_height
	local tree = self.tree
	local leaves = self.leaves
	local fruit = self.fruit
	local limbs = self.limbs
	local ht = self.ht
	for r = min_r, max_r do
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
			self:cacheMTS(idx)
		end
		idx = idx + 1
	end
end

local function schematic_register_to_biome(self, biome_name, decoparams)
	local r
	local name = self.name
	local min_r = self.min_r
	local max_r = self.max_r
	local place_on = decoparams.place_on
	local y_min = decoparams.y_min
	local y_max = decoparams.y_max
	local fill_ratio_divisor = decoparams.fill_ratio
	for idx, schem in pairs(aus.schematics[name]) do
		-- index and radius are a fixed amount apart so we can reconstruct r
		r = idx + (min_r-1)
		minetest.register_decoration({
			deco_type = "schematic",
			sidelen = 80,
			place_on = place_on,
			y_min = y_min,
			y_max = y_max,
			fill_ratio = (max_r-r+1)/fill_ratio_divisor,
			biomes = {biome_name},
			schematic = schem,
			flags = "place_center_x, place_center_z",
			rotation = "random",
		})
	end
end

function TreeSchematic(name, min_r, max_r, ht, fruit,
		limbs, tree, leaves, trunk_height)

	return {
		name = name,
		min_r = min_r,
		max_r = max_r,
		ht = ht,
		fruit = fruit,
		limbs = limbs,
		tree = tree,
		leaves = leaves,
		trunk_height = trunk_height,

		cacheMTS = schematic_cacheMTS,
		ensure_schem = schematic_ensure_schem,
		register_to_biome = schematic_register_to_biome,
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
	schem:ensure_schem()
	schem:register_to_biome(biome, decoparams)
end

-- The *Schematic objects are not needed after init as the schematic live inside
-- Minetest.
function aus.clear_schem_cache()
	aus.schematics_cache = nil
end
