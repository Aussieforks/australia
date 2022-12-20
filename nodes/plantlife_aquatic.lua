local pa = {}
aus.plantlife_aquatic = pa

local growth_targets = {}
pa.growth_targets = growth_targets

local iswater = function(node)
	return node.name == "default:water_source"
		or node.name == "default:water_flowing"
end
aus.iswater = iswater

-- Since light won't be sampled at a frequent interval we assume daytime growth
-- over time. Minimum interval: 60, (artificially shallow) max: 1600
-- (minimum light level of 1 needed to grow at all)
local function photosynthesis_interval(pos)
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
	return 3, 5--(1/3)*median_interval, (5/3)*median_interval
end
pa.photosynthesis_interval = photosynthesis_interval

local function start_timer(pos)
	local timer = minetest.get_node_timer(pos)
	local min_interval, max_interval = photosynthesis_interval(pos)
	timer:start(math.random(min_interval, max_interval))
end
pa.start_timer = start_timer

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
			start_timer(pos)
			if gentime then
				minetest.set_node(pos, {name = "default:sand"})
			end
			return
		end

		if (minetest.get_node_light(above) >= 1 or gentime) then
			minetest.set_node(above, {name = growth_targets[node.name]})
		else
			start_timer(pos)
		end
	else
		if above_node.name ~= growth_targets[node.name] then
			minetest.set_node(pos, {name = "default:stone"})
		end
		start_timer(pos)
	end
end
aus.plantlife_aquatic.grow = grow

local default_nodebox = {
		type = "fixed",
		fixed = {-0.40625, -0.40625, -0.40625, 0.40625, 0.375, 0.40625},
}
pa.default_nodebox = default_nodebox

-- [[ Node base definition
--
-- TODO: Transform all registration functions to using these basedefs and
-- closures, starting with coral ->

local function base_def_on_timer_closure(nn_dead, nn_stone)
	-- Die if not kept underwater.
	return function(pos)
		local above = minetest.get_node(vector.new(pos.x, pos.y+1, pos.z))
		if not iswater(above) then
			minetest.set_node(pos, {name=nn_dead})
			local below = vector.new(pos.x, pos.y-1, pos.z)
			if minetest.get_node(below).name == nn_stone then
				minetest.set_node(vector.new(pos.x, pos.y-1, pos.z), {name="default:stone"})
			end
		else
			minetest.get_node_timer(pos):start(math.random(22,38))
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
		start_timer(below)
	end
end
pa.base_def_on_destruct_closure = base_def_on_destruct_closure

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

	-- Keep a timer where we will check if the coral will still live
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(math.random(22,38))
	end,

	--on_timer = base_def_on_timer_closure(nn_dead, nn_stone),
	--on_destruct = base_def_on_destruct_closure(nn_stone),
}
pa.aquatic_life_base_def = aquatic_life_base_def


-- [[ Dead node - base_def suffices for now
--

-- [[ Stone node
--

local stone_basedef_on_construct = function(pos)
	local min_interval, max_interval = photosynthesis_interval(pos)
	minetest.get_node_timer(pos):start(math.random(min_interval, max_interval))
end
pa.stone_basedef_on_construct = stone_basedef_on_construct

local stone_basedef_on_timer_closure = function(nodename_plant)
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

local aquatic_life_stone_basedef = {
	tiles = {"aus_coral_stone.png"},
	inventory_image = "aus_coral_stone.png^", --subclasses concat with this
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = "default:stone",
	sounds = default.node_sound_stone_defaults(),
	on_construct = stone_basedef_on_construct,
	--on_timer = stone_basedef_on_timer_closure,
}
pa.stone_basedef = aquatic_life_stone_basedef

--[[
Register an aquatic stone life species and its spawning stone. The stone must
be registered to appropriate biomes as an ore separately for it to appear in
the world.
A ? after the property name means it is optional
AquaticStoneLifeDef = {
	nodename = "australia:"..., -- the coral
	nodename_stone? = "australia:, -- defaults to a pattern based on nodename,
		as in e.g. hammer_coral or staghorn_coral_blue
	image = "*.png", -- the coral's inventory image. .JPEG is NOT supported
		without providing an explicit image_bleached. (use .jpg instead)
	drawtype?, -- the coral's drawtype (to support nodeboxes instead of plantlikes)
	nodebox?, -- for nodebox drawtype, the nodebox definition
}
--]]
--TODO: Refactor aquatic_stone_life as parent of coral
--[[ abtract function aus.register_aquatic_stone_life(nodenames, def, def_dead, def_stone)
	assert(nodenames[def], "Aquatic life needs a base node name")
	assert(nodenames[def_dead], "Aquatic life needs a dead node name")
	assert(nodenames[def_stone], "Aquatic life needs a stone node name")

	local nodename = def.nodename
	assert(nodename, "Node needs a name.")

	local image = def.image
	assert(image, "Aquatic life needs an image.")

	local merged_def = table.copy(aquatic_life_base_def)
	for k,v in pairs(def) do
		merged_def[k] = v
	end
	minetest.register_node(nodenames[def_base], merged_def)

	merged_def = table.copy(aquatic_life_dead_base_def)
	for k,v in pairs(def_dead) do
		merged_def[k] = v
	end
	minetest.register_node(nodenames[def_dead], merged_def)

	merged_def = table.copy(aquatic_life_stone_base_def)
	for k,v in pairs(def_stone) do
		merged_def[k] = v
	end
	minetest.register_node(nodenames[def_dead], merged_def)

	merged_def = table.copy(aquatic_life_stone_base_def)
	minetest.register_node(nodename_stone[def_stone], {
	})
end --]]

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
