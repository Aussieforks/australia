-- aus/nodes/coral.lua
-- Corals and other nodes that grow from stony beds on the sea floor.
local pa = aus.plantlife_aquatic

local growth_targets = pa.growth_targets
local grown_from = pa.grown_from
local iswater = aus.iswater
local grow = pa.grow
local destroy_staggered = pa.destroy_staggered
local start_timer_checkup = pa.start_timer_checkup

local nodebox = {
	type = "fixed",
	fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
}

local function tall_kelp_middle_on_destruct_closure(nn_above, nn_below)
	return function(pos)
		local above = vector.new(pos.x, pos.y+1, pos.z)
		local abovenode = minetest.get_node(above)
		if abovenode.name:match(nn_above) then
			destroy_staggered(above)
		end

		-- Restart stone timer as if the plant is brand new
		local below = vector.new(pos.x, pos.y-1, pos.z)
		if minetest.get_node(below).name == nn_below then
			local on_construct = minetest.registered_nodes[nn_below].on_construct
			on_construct(below)
		end
	end
end

local middle_lookaround = {
	vector.new(1,0,0),
	vector.new(-1,0,0),
	vector.new(0,0,1),
	vector.new(0,0,-1),
}

local function tall_kelp_top_will_die(pos, nodename_top, nodename_middle,
	nodename_stone)

	-- Needs a middle or stone below
	local die
	local below_name = minetest.get_node(vector.new(pos.x, pos.y-1, pos.z)).name
	die = not (below_name == nodename_middle or
		below_name == nodename_stone)
	if die then return true end

	-- Needs at least one water adjacent and all others must be sea nodes
	local good_neighbours = 0
	local watery_neighbours = 0
	for _, delta in pairs(middle_lookaround) do
		local checknode = minetest.get_node(pos+delta)
		if (iswater(checknode)) then
			watery_neighbours = watery_neighbours + 1
			good_neighbours = good_neighbours + 1
		elseif checknode.name == nodename_middle
		  or checknode.name == nodename_top then
			good_neighbours = good_neighbours + 1
		else
			local grp = minetest.registered_nodes[checknode.name].groups
			if grp and grp.sea then
				good_neighbours = good_neighbours + 1
			end
		end
	end
	if good_neighbours < 1 or watery_neighbours < 1 then
		return true
	end

	-- Must not have air above
	if minetest.get_node(vector.new(pos.x, pos.y+1, pos.z)).name == "air" then
		return true
	end

end

local function tall_kelp_top_on_timer_closure(nodename_top, nodename_middle,
	nodename_stone, nodename_dead)

	return function(pos)--, node, active_object_count, active_object_count_wider)
		local will_grow = true
		-- Check for _death_ conditions
		if tall_kelp_top_will_die(pos, nodename_top, nodename_middle,
			nodename_stone, nodename_dead)
		then
			minetest.swap_node(pos, {name = nodename_dead})
			-- Restart stone timer as if the plant is brand new
			local below = vector.new(pos.x, pos.y-1, pos.z)
			if minetest.get_node(below).name == nodename_stone then
				local on_construct =
					minetest.registered_nodes[nodename_stone].on_construct
				on_construct(below)
			end
			will_grow = false
		end

		-- Check the roots of the plant
		local pos_below = vector.new(pos.x, pos.y-1, pos.z)
		local below_node = minetest.get_node(pos_below)
		if not (below_node.name == nodename_middle
			or below_node.name == nodename_stone) then
			minetest.dig_node(pos)
			will_grow = false
		end

		if not will_grow then return end

		-- Check for _growing_ conditions
		local growing_room_available = true
		local pos_iter = vector.new(pos.x, pos.y+1, pos.z)
		repeat
			-- Flowing water just won't do
			if minetest.get_node(pos_iter).name ~= "default:water_source" then
				growing_room_available = false
			end
			pos_iter.y = pos_iter.y + 1
		until pos_iter.y == pos.y + 4

		if growing_room_available then
			minetest.set_node(pos, {name = nodename_middle})
			pos.y = pos.y + 1
			minetest.set_node(pos, {name = nodename_top})
		end

		start_timer_checkup(pos)
	end
end

local function tall_kelp_middle_on_timer_closure(nodename_middle,
	nodename_middle_dead, nodename_stone)
	return function(pos)
		local found_water = false
		for _, delta in pairs(middle_lookaround) do
			local checkpos = pos+delta
			if iswater(minetest.get_node(checkpos)) then
				found_water = true
				break
			end
		end

		-- Check the roots of the plant
		local pos_below = vector.new(pos.x, pos.y-1, pos.z)
		local below_node = minetest.get_node(pos_below)
		if not (below_node.name == nodename_middle
			or below_node.name == nodename_stone) then
			minetest.dig_node(pos)
			return
		end

		-- Die
		if not found_water then
			minetest.swap_node(pos, {name=nodename_middle_dead})
		end

		start_timer_checkup(pos)
	end
end

local tall_kelp_stone_on_timer_closure = function(nodename_plant, nodename_plant_middle)
	return function(pos)
		local above = minetest.get_node(vector.new(pos.x, pos.y+1, pos.z))
		if not (iswater(above)
			or above.name == nodename_plant
			or above.name == nodename_plant_middle)
		then
			minetest.set_node(pos, {name="default:stone"})
		else
			grow(pos, minetest.get_node(pos))
		end
	end
end

--[[
Register a tall kelp species and its spawning stone. The stone must be
registered to appropriate biomes as an ore separately for it to appear in the
world. A ? after the property name means it is optional
TallKelpDef = {
	nodename = "australia:"..., -- the top kelp node
	nodename_stone? = "australia:, -- defaults to prefixing nodename with :_stone
	nodename_dead? = "australia:"... -- defaults to a suffix based on
		nodename, but can be overriden for e.g. groups of colour varieties
	nodename_middle? = "australia:"... The nodename of middle and lower nodes
		in the kelp defaults to a suffix based on nodename, but can be overriden
	local nodename_middle_dead = def.nodename_middle_dead
	description, -- Should be Scientific Name: Common name (colour/variety)?
	image = "*.png", -- the lifeforms's inventory image. .JPEG is NOT supported
		without providing an explicit image_dead. (use .jpg instead)
	image_dead = "*.png" -- the image to use when the lifeform dies due to lack of
		water
	image_middle = texture -- the image to use for the middle and bottom nodes
		of the kelp (in other words every node except the top one)
	image_middle_dead = "" -- the image to use for the dead version of the
		middle and bottom nodes of the kelp, in case the plant has its water
		removed further down than the top.
	drawtype?, -- the coral's drawtype (to support nodeboxes instead of
		plantlikes)
	nodebox?, -- for nodebox drawtype, the nodebox definition. Also used for
		selection boxes for any drawye.
}
--]]
function pa.register_tall_kelp(def)
	-- Preamble
	pa.register_plantlife_aquatic_common_start(def)
	local nodename = def.nodename
	local description = def.description
	local image = def.image

	local nodename_stone = def.nodename_stone or pa.derive_stone_name(nodename)
	local nodename_middle = def.nodename_middle or nodename .. "_middle"
	local nodename_middle_dead = def.nodename_middle_dead
		or nodename_middle .. "_dried"
	-- common function `grow` will look up this table in the nodetimer. I _think_ this a
	-- better approach than closures.
	growth_targets[nodename_stone] = nodename

	-- attached_node: Cannot make it attached or adjacent sand will cause
	-- collapse; also punching the middle would cause entire plant collapse.
	local groups = {snappy=3, seaplants=1, sea=1}
	local sounds = default.node_sound_leaves_defaults()
	local nn_dead = def.nodename_dead or (nodename .. "_dried")

	-- Spawning stone crafting recipe
	pa.register_stone_craft(nodename, nodename_stone)

	-- Base plant node
	local base_def = table.copy(pa.aquatic_life_base_def)
	pa.basedef_do_common_properties(base_def,
		description, base_def.drawtype, image, groups, sounds, nodebox)
	base_def.climbable = true
	base_def.on_timer = tall_kelp_top_on_timer_closure(nodename,
		nodename_middle, nodename_stone, nn_dead)
	base_def.on_destruct = pa.base_def_on_destruct_closure(nodename_stone)
	base_def.post_effect_color = def.post_effect_color
	minetest.register_node(nodename, base_def)

	-- Dead node
	local desc_dead = def.desc_dead or string.format("%s (dried)", description)
	local image_dead = def.image_dead
		or aus.fname_with_suffix_ext(image, "_dried")
	local groups_dead = {attached_node=1, snappy=3, food_seaweed=1}
	local dead_def = table.copy(pa.aquatic_life_base_def)
	pa.basedef_do_common_properties(dead_def,
		desc_dead, dead_def.drawtype, image_dead, groups_dead, sounds, nodebox)
	dead_def.post_effect_color = def.post_effect_color -- or derivative?
	dead_def.waving = 0
	dead_def.drowning = 0
	dead_def.move_resistance = 1
	dead_def.liquid_move_physics = false
	dead_def.on_use = minetest.item_eat(1)
	dead_def.on_timer = nil

	minetest.register_node(nn_dead, dead_def)
	-- Drying kelp in a furnace is an alternative to air drying
	minetest.register_craft({
		type = "cooking",
		recipe = nodename,
		output = nn_dead,
		cooktime = 5,
	})

	-- Stone node
	local stone_def = table.copy(pa.stone_basedef)
	stone_def.description = string.format("%s stone", description)
	stone_def.inventory_image = stone_def.inventory_image .. image
	stone_def.on_timer = tall_kelp_stone_on_timer_closure(nodename, nodename_middle)
	minetest.register_node(nodename_stone, stone_def)

	-- Middle node
	local middle_def = table.copy(pa.aquatic_life_base_def)
	local middle_desc = string.format("%s middle", description)
	local image_middle = def.image_middle
		or aus.fname_with_suffix_ext(image, "_middle")
	pa.basedef_do_common_properties(middle_def,
		middle_desc, middle_def.drawtype, image_middle, groups, sounds, nodebox)
	middle_def.post_effect_color = def.post_effect_color
	middle_def.climbable = true
	middle_def.drowning = 1
	middle_def.on_destruct = tall_kelp_middle_on_destruct_closure(
		"australia:kelp_giant_brown", "australia:stone_kelp_giant_brown")
	middle_def.groups = {snappy=3, seaplants=1, sea=1, not_in_creative_inventory=1}
	middle_def.drop = nodename
	middle_def.on_timer = tall_kelp_middle_on_timer_closure(nodename_middle,
		nodename_middle_dead, nodename_stone)
	minetest.register_node(nodename_middle, middle_def)
	grown_from[nodename_middle] = nodename

	-- Dead middle node
	local desc_middle_dead = desc_dead
	local image_middle_dead = def.image_middle_dead
		or aus.fname_with_suffix_ext(image, "_middle_dried")
	local middle_dead_def = table.copy(dead_def)
	pa.basedef_do_common_properties(middle_dead_def,
		desc_middle_dead, middle_dead_def.drawtype, image_middle_dead, groups_dead, sounds, nodebox)
	middle_dead_def.desc = desc_middle_dead
	middle_dead_def.image = image_middle_dead
	middle_dead_def.groups = {attached_node=1, snappy=3, food_seaweed=1}
	middle_dead_def.post_effect_color = def.post_effect_color -- or derivative?
	middle_dead_def.waving = 0
	middle_dead_def.drowning = 0
	middle_dead_def.drop = nn_dead
	middle_dead_def.liquid_move_physics = false
	middle_dead_def.climbable = true
	minetest.register_node(nodename_middle_dead, middle_dead_def)

end

-- Macrocystis pyrifera: Giant Kelp
pa.register_tall_kelp({
	nodename = "australia:kelp_giant_brown",
	description = "Macrocystis pyrifera: Giant Kelp",
	image = "aus_kelp_giant_brown.png",
	post_effect_color = {a=64, r=100, g=100, b=200},
})
