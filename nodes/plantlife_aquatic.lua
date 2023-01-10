local pa = {}
aus.plantlife_aquatic = pa

local growth_targets = {}
pa.growth_targets = growth_targets

local grown_from = {}
pa.grown_from = grown_from

local iswater = aus.iswater

local photosynthesis_interval
if not aus.debug_mode then
	-- Since light won't be sampled at a frequent interval we assume daytime growth
	-- over time. Minimum interval: 60, (artificially shallow) max: 1600
	-- (minimum light level of 1 needed to grow at all)
	photosynthesis_interval = function(pos)
		local day_ll = minetest.get_node_light(vector.new(pos.x, pos.y+1, pos.z), 0.5)
		if day_ll == nil then
			-- REPORT: Only triggered when LBMs don't run on first world run,
			-- whereby no corals spawn at first.
			minetest.log("warning", string.format(
				"[Australia] Nil light above %s when calculating aquatic "
				.."photosynthesis assuming 0",
				pos))
			day_ll = 0
		end
		local median_interval = 60*(minetest.LIGHT_MAX - day_ll + 3)
		return (1/3)*median_interval, (5/3)*median_interval
	end
else
	photosynthesis_interval = function(pos)
		return 3,5
	end
end
pa.photosynthesis_interval = photosynthesis_interval

local function start_timer_growth(pos)
	local timer = minetest.get_node_timer(pos)
	local min_interval, max_interval = photosynthesis_interval(pos)
	timer:start(math.random(min_interval, max_interval))
end
pa.start_timer_growth = start_timer_growth

local start_timer_checkup
if not aus.debug_mode then
	start_timer_checkup = function(pos)
		minetest.get_node_timer(pos):start(math.random(22,38))
	end
else
	start_timer_checkup = function(pos)
		minetest.get_node_timer(pos):start(math.random(3,4))
	end
end
pa.start_timer_checkup = start_timer_checkup

--[[
@arg pos: The position of the stone.
@arg node: The node information table as provided in callbacks.
@arg gentime: Whether the plant is being grown at world generation time.
coral reefs can grow as low as 50m, but minetest's topography is
exagerrated. We therefore limit it to where light is available.
--]]
local function grow(pos, node, gentime)
	local above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local above_node = minetest.get_node(above)

	if iswater(above_node) then
		local above_above_node =
			minetest.get_node(vector.new(above.x, above.y+1, above.z))
		-- Too shallow, coral would die after growth
		if not iswater(above_above_node) then
			start_timer_growth(pos)
			if gentime then
				minetest.set_node(pos, {name = "default:sand"})
			end
			return
		end

		if (minetest.get_node_light(above) >= 1 or gentime) then
			minetest.set_node(above, {name = growth_targets[node.name]})
		else
			start_timer_growth(pos)
		end
	else
		if above_node.name ~= growth_targets[node.name]
			 -- for e.g. middle of kelp
			and (not grown_from[above_node.name] == node.name)
		then
			minetest.set_node(pos, {name = "default:stone"})
		end
		start_timer_growth(pos)
	end
end
aus.plantlife_aquatic.grow = grow

local function destroy_staggered(pos)
	minetest.after(math.random(1, 2) - 0.8, minetest.dig_node, pos)
end
pa.destroy_staggered = destroy_staggered

local function derive_stone_name(nodename)
	local colonidx = nodename:find(":")
	assert(colonidx, string.format("No colon found in nodename: %s", nodename))

	-- Prefix the part after the colon with 'stone_'
	return nodename:sub(0, colonidx) .. 'stone_' ..  nodename:sub(colonidx+1,-1)
end
pa.derive_stone_name = derive_stone_name

local default_nodebox = {
		type = "fixed",
		fixed = {-0.40625, -0.40625, -0.40625, 0.40625, 0.375, 0.40625},
}
pa.default_nodebox = default_nodebox

-- [[ Node base definition
--
-- All aquatic life registration functions should use these basedefs and
-- closures to reduce code duplication.

local function base_def_on_timer_closure(nn_dead, nn_stone)
	-- Die if not kept underwater.
	return function(pos)
		local above = minetest.get_node(vector.new(pos.x, pos.y+1, pos.z))
		if not iswater(above) then
			minetest.set_node(pos, {name=nn_dead})
			local below = vector.new(pos.x, pos.y-1, pos.z)
			if minetest.get_node(below).name == nn_stone then
				-- Nodes are attached, so set_node would cause them to drop on
				-- the ground
				minetest.swap_node(vector.new(pos.x, pos.y-1, pos.z), {name="default:stone"})
			end
		else
			start_timer_checkup(pos)
		end
	end
end
pa.base_def_on_timer_closure = base_def_on_timer_closure

local function base_def_on_destruct_closure(nn_stone)
	-- Restart timer of any plant life spawning stone below
	return function(pos)
		local below = vector.new(pos.x, pos.y-1, pos.z)
		if minetest.get_node(below).name ~= nn_stone then
			return
		end
		start_timer_growth(below)
	end
end
pa.base_def_on_destruct_closure = base_def_on_destruct_closure

local base_def_on_construct = start_timer_checkup
pa.base_def_on_construct = base_def_on_construct

local aquatic_life_base_def = {
	drawtype = "plantlike",
	waving = 1,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	liquid_move_physics = true,
	move_resistance = 3,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	selection_box = default_nodebox,
	node_box = default_nodebox,
	collision_box = default_nodebox,

	-- Keep a timer where we will check if the plant life will still live
	on_construct = base_def_on_construct,
	on_punch = aus.timer_info,

	--on_timer = base_def_on_timer_closure(nn_dead, nn_stone),
	--on_destruct = base_def_on_destruct_closure(nn_stone),
}
pa.aquatic_life_base_def = aquatic_life_base_def


-- [[ Dead node - base_def suffices for now
--

-- [[ Stone node
--

local function stone_basedef_on_construct(pos)
	local min_interval, max_interval = photosynthesis_interval(pos)
	minetest.get_node_timer(pos):start(math.random(min_interval, max_interval))
end
pa.stone_basedef_on_construct = stone_basedef_on_construct

local function stone_basedef_on_timer_closure(nodename_plant)
	return function(pos)
		local above = minetest.get_node(vector.new(pos.x, pos.y+1, pos.z))
		if not (iswater(above) or above.name == nodename_plant) then
			minetest.set_node(pos, {name="default:stone"})
		else
			grow(pos, minetest.get_node(pos))
		end
	end
end
pa.stone_basedef_on_timer_closure = stone_basedef_on_timer_closure

local function stone_basedef_on_destruct(pos)
	-- Used in case the plant node is not an attached node e.g. tall kelps
	local above = vector.new(pos.x, pos.y+1, pos.z)
	local nodename = minetest.get_node(pos).name
	if minetest.get_node(above).name:match(growth_targets[nodename]) then
		destroy_staggered(above)
	end
end
pa.stone_basedef_on_destruct = stone_basedef_on_destruct

local stone_basedef = {
	tiles = {"aus_coral_stone.png"},
	inventory_image = "aus_coral_stone.png^", --subclasses concat with this
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = "default:stone",
	sounds = default.node_sound_stone_defaults(),
	on_punch = aus.timer_info,
	on_construct = stone_basedef_on_construct,
	on_destruct = stone_basedef_on_destruct,
	--on_timer = stone_basedef_on_timer_closure,
}
pa.stone_basedef = stone_basedef

--[[
Register an aquatic stone life species and its spawning stone. The stone must
be registered to appropriate biomes as an ore separately for it to appear in
the world.
A ? after the property name means it is optional
AquaticStoneLifeDef = {
	nodename = "australia:"..., -- the lifeform
	nodename_stone? = "australia:, -- defaults to a pattern based on nodename,
		as in e.g. hammer_coral or staghorn_coral_blue
	image = "*.png", -- the coral's inventory image. .JPEG is NOT supported
		without providing an explicit image_bleached. (use .jpg instead)
	drawtype?, -- the lifeforms's drawtype (to support nodeboxes instead of plantlikes)
	nodebox?, -- for nodebox drawtype, the nodebox definition
	-- Other properties may exist in subclasses
}
--]]
-- This 'abstract' function is a general guide on how to implement subclasses of
-- aquatic stone life: A table copy followed by setting/override specific
-- properies.
--[[ abtract function pa.register_aquatic_stone_life(def)
	register_plantlife_aquatic_common_start(def)

	local merged_def = table.copy(aquatic_life_base_def) -- If using a subclassed def
	for k,v in pairs(subclass_base_def) do
		merged_def[k] = v
	end
	base_def.description = description
	-- .. other properties
	minetest.register_node(nodenames[def.nodename], merged_def)

	local nodename_dead = something(def.nodename)
	merged_def = table.copy(aquatic_life_dead_base_def) -- If using a subclassed def
	for k,v in pairs(subclass_def_dead) do
		merged_def[k] = v
	end
	-- .. other properties
	minetest.register_node(nodename_dead, merged_def)

	local nodename_stone = something(def.nodename)
	merged_def = table.copy(aquatic_life_stone_base_def) -- If using a subclassed def
	for k,v in pairs(subclass_def_stone) do
		merged_def[k] = v
	end
	-- .. other properties
	minetest.register_node(nodename_stone, merged_def)

	-- Any other subclass-related extra nodes
	})
end --]]

local function register_plantlife_aquatic_common_start(def)
	assert(def.nodename, "Aquatic life needs nodename")
	assert(def.description, "Aquatic life needs a description")
	assert(def.image, "Aquatic life needs an image")
end
pa.register_plantlife_aquatic_common_start = register_plantlife_aquatic_common_start

local function register_stone_craft(nodename, nodename_stone)
	minetest.register_craft({
		output = nodename_stone,
		recipe = {
			{nodename, nodename, nodename},
			{nodename, nodename_stone, nodename},
			{nodename, nodename, nodename},
		},
	})
end
pa.register_stone_craft = register_stone_craft

local function basedef_do_common_properties(tab,
	description, drawtype, image, groups, sounds, nodebox)

	tab.description = description
	tab.drawtype = drawtype
	tab.tiles = {image}
	tab.inventory_image = image
	tab.wield_image = image
	tab.groups = groups
	tab.sounds = sounds
	tab.selection_box = nodebox
	tab.node_box = nodebox
	tab.collision_box = nodebox
end
pa.basedef_do_common_properties = basedef_do_common_properties

-- Runs any tasks for after all the plant lifeforms are all registered.
-- Currently just registering the LBM
local function finalise_plantlife_aquatic()
	local lbm_targets = {}
	for stone, _ in pairs(growth_targets) do
		table.insert(lbm_targets, stone)
	end

	minetest.register_lbm({
		label = "Ensure aussie aquatic plantlife growth",
		name = "australia:ensure_pa_growth",
		nodenames = lbm_targets,
		-- It does not seem we can remove this, because we rely on it to spawn
		-- corals at worldgen time as well as upgrade old plant lifeforms.
		run_at_every_load = true,
		action = function(pos, node)
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				grow(pos, node, true)
			end
		end,
	})
end
pa.finalise_plantlife_aquatic = finalise_plantlife_aquatic

-- Halodule uninervis: Narrowleaf Seagrass
minetest.register_node("australia:sea_grass", {
	description = "Halodule uninervis: Narrowleaf Seagrass",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.0,
	tiles = {"aus_sea_grass.png"},
	inventory_image = "aus_sea_grass.png",
	wield_image = "aus_sea_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy = 3, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})
