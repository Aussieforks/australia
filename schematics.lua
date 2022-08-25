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

-- In the below 2 functions: Provide either const_fill_ratio to have all
-- schematics have the same fill ratio, or fill_ratio_divisor to have the fill
-- ratio scale with the size (radius or height) of the tree

local function schematic_register_to_biome_iter_r(self, biome_name, decoparams)
	local r
	local name = self.name
	local min_r = self.min_r
	local max_r = self.max_r
	local place_on = decoparams.place_on
	local y_min = decoparams.y_min
	local y_max = decoparams.y_max
	for idx, schem in pairs(aus.schematics[name]) do
		-- index and radius are a fixed amount apart so we can reconstruct r
		r = idx + (min_r-1)
		local fill_ratio
		if (decoparams.fill_ratio_divisor) then
			fill_ratio = (max_r-r+1)/decoparams.fill_ratio_divisor
		elseif (decoparams.const_fill_ratio) then
			fill_ratio = decoparams.const_fill_ratio
		else
			assert(false, "No fill ratio provided: " .. self.name)
		end
		minetest.register_decoration({
			deco_type = "schematic",
			sidelen = 80,
			place_on = place_on,
			y_min = y_min,
			y_max = y_max,
			fill_ratio = fill_ratio,
			biomes = {biome_name},
			schematic = schem,
			flags = "place_center_x, place_center_z",
			rotation = "random",
		})
	end
end

local function schematic_register_to_biome_iter_h(self, biome_name, decoparams)
	--local h
	local r = self.r
	local name = self.name
	--local min_ht = self.min_ht
	local max_ht = self.max_ht
	local place_on = decoparams.place_on
	local y_min = decoparams.y_min
	local y_max = decoparams.y_max
	for --[[idx]]_, schem in pairs(aus.schematics[name]) do
		-- index and height are a fixed amount apart so we can reconstruct h,
		-- however, existing code uses r, making fill_ratio constant. Fix?
		--h = idx + (min_ht-1)

		local fill_ratio
		if (decoparams.fill_ratio_divisor) then
			fill_ratio = (max_ht-r+1)/decoparams.fill_ratio_divisor
		elseif (decoparams.const_fill_ratio) then
			fill_ratio = decoparams.const_fill_ratio
		else
			assert(false, "No fill ratio provided: " .. self.name)
		end

		minetest.register_decoration({
			deco_type = "schematic",
			sidelen = 80,
			place_on = place_on,
			y_min = y_min,
			y_max = y_max,
			fill_ratio = fill_ratio,
			biomes = {biome_name},
			schematic = schem,
			flags = "place_center_x, place_center_z",
			rotation = "random",
		})
	end
end

-- Ensure the schematic exists
local function schematic_ensure_schem_iter_r(self)
	local name = self.name
	if aus.schematics[name] ~= nil then return end
	aus.schematics[name] = {}

	-- Locals save multiple table lookup in theory
	local idx = 1
	local min_r = self.min_r
	local max_r = self.max_r
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
			table.insert(aus.schematics[name], self:gen_schematic(r))
			self:cacheMTS(idx)
		end
		idx = idx + 1
	end
end

local function schematic_ensure_schem_iter_h(self)
	local name = self.name
	if aus.schematics[name] ~= nil then return end
	aus.schematics[name] = {}

	-- Locals save multiple table lookup in theory
	local idx = 1
	local min_ht = self.min_ht
	local max_ht = self.max_ht
	for h = min_ht, max_ht do
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
			table.insert(aus.schematics[name], self:gen_schematic(h))
			self:cacheMTS(idx)
		end
		idx = idx + 1
	end
end


-- Per-instance radius variable height
-- function aus.generate_rainforest_tree_schematic(trunk_height, r, trunk, leaf)
local function schematic_rainforest_tree_schematic_gen_schematic(self,  h)
	return aus.generate_rainforest_tree_schematic(h, self.r,
		self.tree, self.leaves)
end

-- Per-instance radius, variable height
--function aus.generate_fanpalm_tree_schematic(trunk_height, r, trunk, leaf)
local function schematic_fanpalm_tree_schematic_gen_schematic(self,  h)
	return aus.generate_fanpalm_tree_schematic(h, self.r,
		self.tree, self.leaves)
end

-- Constant radius, variable height
--function aus.generate_mangrove_tree_schematic(trunk_height, trunk, leaf)
local function schematic_mangrove_tree_schematic_gen_schematic(self, h)
	return aus.generate_mangrove_tree_schematic(h, self.tree, self.leaves)
end

-- Variable radius, per-instance height
--function aus.generate_tree_schematic(trunk_height, radii, trunk, leaf, fruit, limbs)
local function schematic_tree_schematic_gen_schematic(self, r)
	return aus.generate_tree_schematic(self.trunk_height,
		{x=r, y=self.h, z=r}--[[<-radii--]],
		self.tree, self.leaves, self.fruit, self.limbs)
end

-- Variable radius, per-instance height
--function aus.generate_big_tree_schematic(trunk_height, radii, trunk, leaf, fruit, limbs)
local function schematic_big_tree_schematic_gen_schematic(self, r)
	return aus.generate_big_tree_schematic(self.trunk_height,
		{x=r, y=self.h, z=r}--[[<-radii--]],
		self.tree, self.leaves, self.fruit, self.limbs)
end

-- Variable radius, per-instance height
--function aus.generate_giant_tree_schematic(trunk_height, radii, trunk, leaf, fruit, limbs)--
local function schematic_giant_tree_schematic_gen_schematic(self, r)
	return aus.generate_giant_tree_schematic(self.trunk_height,
		{x=r, y=self.h, z=r}--[[<-radii--]],
		self.tree, self.leaves, self.fruit, self.limbs)
end

-- Variable scalar radius, per-instance height
-- function aus.generate_conifer_schematic(trunk_height, radius, trunk, leaf, fruit)
local function schematic_conifer_schematic_gen_schematic(self, r)
	return aus.generate_conifer_schematic(self.trunk_height,
		r, self.tree, self.leaves, self.fruit)
end

--[[ ITreeSchem
{
	name: ItemString,
	tree: ItemString,
	leaves: ItemString,

	fruit: ItemString?,
	limbs: ItemString?,

	min_r, max_r, h || min_ht, max_ht, r

	cacheMTS: function(self, idx),
	register_to_biome: function(self, biome_name, {
		place_on = place_on,
		y_min = y_min,
		y_max = y_max,
		fill_ratio = (max_r-r+1)/fill_ratio_divisor,
	}),
	ensure_schem: function(self),
	gen_schematic: function(self, iter_param) -- height or radius
} --]]

local function ITreeSchem(name, tree, leaves)
	return {
		name = name,
		tree = tree,
		leaves = leaves,

		cacheMTS = schematic_cacheMTS,
	}
end

local function ITreeSchemIterR(name, tree, leaves, min_r, max_r, h)
	local t = ITreeSchem(name, tree, leaves)
	t.min_r = min_r
	t.max_r = max_r
	t.h = h
	t.register_to_biome = schematic_register_to_biome_iter_r
	t.ensure_schem = schematic_ensure_schem_iter_r
	return t
end

function aus.ConiferSchematic(name, tree, leaves, min_r, max_r,
		fruit, trunk_height)
	local t = ITreeSchemIterR(name, tree, leaves, min_r, max_r)
	t.trunk_height  = trunk_height
	t.fruit = fruit
	t.gen_schematic = schematic_conifer_schematic_gen_schematic
	return t
end

local function IGenericTreeSchematic(name, tree, leaves, min_r, max_r, h,
		fruit, limbs, trunk_height)
	local t = ITreeSchemIterR(name, tree, leaves, min_r, max_r, h)
	t.fruit = fruit
	t.limbs = limbs
	t.trunk_height = trunk_height
	return t
end

function aus.TreeSchematic(name, tree, leaves, min_r, max_r, h,
		fruit, limbs, trunk_height)
	local t = IGenericTreeSchematic(name, tree, leaves, min_r, max_r, h,
		fruit, limbs, trunk_height)
	t.gen_schematic = schematic_tree_schematic_gen_schematic
	return t
end

function aus.BigTreeSchematic(name, tree, leaves, min_r, max_r, h,
		fruit, limbs, trunk_height)
	local t = IGenericTreeSchematic(name, tree, leaves, min_r, max_r, h,
		fruit, limbs, trunk_height)
	t.gen_schematic = schematic_big_tree_schematic_gen_schematic
	return t
end

function aus.GiantTreeSchematic(name, tree, leaves, min_r, max_r, h,
		fruit, limbs, trunk_height)
	local t = IGenericTreeSchematic(name, tree, leaves, min_r, max_r, h,
		fruit, limbs, trunk_height)
	t.gen_schematic = schematic_giant_tree_schematic_gen_schematic
	return t
end


local function ITreeSchemIterH(name, tree, leaves, min_ht, max_ht, r)
	local t = ITreeSchem(name, tree, leaves)
	t.min_ht = min_ht
	t.max_ht = max_ht
	t.r = r
	t.register_to_biome = schematic_register_to_biome_iter_h
	t.ensure_schem = schematic_ensure_schem_iter_h
	return t
end

function aus.RainforestTreeSchematic(name, tree, leaves, min_ht, max_ht, r)
	local t = ITreeSchemIterH(name, tree, leaves, min_ht, max_ht, r)
	t.gen_schematic = schematic_rainforest_tree_schematic_gen_schematic
	return t
end

function aus.FanPalmTreeSchematic(name, tree, leaves, min_ht, max_ht, r)
	local t = ITreeSchemIterH(name, tree, leaves, min_ht, max_ht, r)
	t.gen_schematic = schematic_fanpalm_tree_schematic_gen_schematic
	return t
end

function aus.MangroveTreeSchematic(name, tree, leaves, min_ht, max_ht)
	local t = ITreeSchemIterH(name, tree, leaves, min_ht, max_ht, nil)
	t.gen_schematic = schematic_mangrove_tree_schematic_gen_schematic
	return t
end

--[[
function aus.TreeSchematic(name, min_r, max_r, ht, fruit,
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
--]]

aus.schematics_cache = {}

-- Caches TreeSchematic etc. objects to avoid multiple instatiation.
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

-- The *Schematic objects are not needed after init as the schematics live
-- inside Minetest.
function aus.clear_schem_cache()
	aus.schematics_cache = nil
end
