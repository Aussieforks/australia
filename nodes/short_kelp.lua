-- aus/nodes/coral.lua
-- Corals and other nodes that grow from stony beds on the sea floor.
local pa = aus.plantlife_aquatic

local growth_targets = pa.growth_targets

local nodebox = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
}

--[[
Register a short kelp species and its spawning stone. The stone must be
registered to appropriate biomes as an ore separately for it to appear in the
world. A ? after the property name means it is optional
ShortKelpDef = {
	nodename = "australia:"..., -- the coral
	nodename_stone? = "australia:, -- defaults to prefixing nodename with :_stone
	nodename_dead? = "australia:"... -- defaults to a suffix based on
		nodename, but can be overriden for e.g. groups of colour varieties
	image = "*.png", -- the kelp's inventory image. .JPEG is NOT supported
		without providing an explicit image_dead. (use .jpg instead)
	image_dead = "*.png" -- the image to use when the plant dies due to lack of
        water
	drawtype?, -- the coral's drawtype (to support nodeboxes instead of
        plantlikes)
	nodebox?, -- for nodebox drawtype, the nodebox definition
}
--]]
function pa.register_short_kelp(def)
	pa.register_plantlife_aquatic_common_start(def)
	local nodename = def.nodename
	local description = def.description
	local image = def.image

	local nodename_stone = def.nodename_stone
        or pa.derive_stone_name(def.nodename)
    -- common function `grow` will look up this table in the nodetimer. I _think_ this a
    -- better approach than closures.
    growth_targets[nodename_stone] = nodename

    local groups = {attached_node=1, snappy=3, seaplants=1, sea=1}
    local sounds = default.node_sound_leaves_defaults()
    local nn_dead = def.nodename_dead or (nodename .. "_dried")

    -- Spawning stone crafting recipe
    pa.register_stone_craft(nodename, nodename_stone)

	local base_def = table.copy(pa.aquatic_life_base_def)
    pa.basedef_do_common_properties(base_def,
        description, base_def.drawtype, image, groups, sounds, nodebox)
	base_def.on_timer = pa.base_def_on_timer_closure(nn_dead, nodename_stone)
	base_def.on_destruct = pa.base_def_on_destruct_closure(nodename_stone)
	base_def.on_punch = function(pos)
		local tmr = minetest.get_node_timer(pos)
		print(string.format("is_started = %s, timeout = %s", tmr:is_started(), tmr:get_timeout()))
	end--]]
	minetest.register_node(nodename, base_def)

	local desc_dead = def.desc_dead or string.format("%s (dried)", description)
	local image_dead = def.image_dead
        or aus.fname_with_suffix_ext(image, "_dried")
    local groups_dead = {attached_node=1, snappy=3, food_seaweed=1}
    local dead_def = table.copy(pa.aquatic_life_base_def)
    pa.basedef_do_common_properties(dead_def,
        desc_dead, base_def.drawtype, image_dead, groups_dead, sounds, nodebox)
    dead_def.waving = 0
    dead_def.drowning = 0
    dead_def.liquid_move_physics = false
    dead_def.climbable = false
    minetest.register_node(nn_dead, dead_def)

    local stone_def = table.copy(pa.stone_basedef)
    stone_def.description = string.format("%s stone", description)
    stone_def.inventory_image = stone_def.inventory_image .. image
    stone_def.on_timer = pa.stone_basedef_on_timer_closure(nodename)
    --[[stone_def.on_punch = function(pos)
        local tmr = minetest.get_node_timer(pos)
        print(string.format("is_started = %s, timeout = %s", tmr:is_started(), tmr:get_timeout()))
    end--]]
    minetest.register_node(nodename_stone, stone_def)
end

-- Ecklonia radiata: Common Kelp (new)
pa.register_short_kelp({
    nodename = "australia:kelp_brown",
    description = "Ecklonia radiata: Common Kelp",
    image = "aus_kelp_brown.png",
})

--[[
-- Ecklonia radiata: Common Kelp (old)
minetest.register_node("australia:kelp_brown", {
	description = "Ecklonia radiata: Common Kelp",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"aus_kelp_brown.png"},
	inventory_image = "aus_kelp_brown.png",
	wield_image = "aus_kelp_brown.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy=3, seaplants=1, sea=1, food_seaweed=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

minetest.register_node("australia:stone_kelp_brown", {
	description = "Ecklonia radiata: Common Kelp stone",
	tiles = {"aus_coral_stone.png"},
	inventory_image = "aus_coral_stone.png^aus_kelp_brown.png",
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm({
	nodenames = {"australia:stone_kelp_brown"},
	interval = 15,
	chance = 5,
	action = function(pos)--, node, active_object_count, active_object_count_wider)
		local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node(yp).name == "default:water_source" or
			minetest.get_node(yp).name == "australia:water_source")
		then
			pos.y = pos.y + 1
			minetest.add_node(pos, {name = "australia:kelp_brown"})
		else
			return
		end
	end
})--]]
