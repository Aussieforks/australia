-- TODO: This is mostly a copy & paste from corals. Refactor to reduce
-- boilerplate.
local pa = aus.plantlife_aquatic
local growth_targets = pa.growth_targets

-- The code would mostly duplicate the coral code, so I have decided to use an
-- override until it seems worth forking the coral code or refactoring to allow
-- further subclassing.
function pa.register_sponge(def)
	pa.register_plantlife_aquatic_common_start(def)
	local nodename = def.nodename
	local description = def.description
	local image = def.image

	local nodename_stone = def.nodename_stone or pa.derive_stone_name(nodename)
	local nn_dead = def.nodename_dead or def.nodename.."_dead"

	-- common function `grow` will look up this table in the nodetimer. I _think_ this a
	-- better approach than closures.
	growth_targets[nodename_stone] = nodename

	local groups = {attached_node=1, oddly_breakable_by_hand=1}
	local sounds = default.node_sound_leaves_defaults()
	local base_def = table.copy(pa.aquatic_life_base_def)
	pa.basedef_do_common_properties(base_def,
		description, def.drawtype or base_def.drawtype, image, groups,
		sounds, base_def.nodebox)
	base_def.on_timer = pa.base_def_on_timer_closure(nn_dead, nodename_stone)
	base_def.on_destruct = pa.base_def_on_destruct_closure(nodename_stone)
	base_def.on_punch = aus.timer_info
	minetest.register_node(nodename, base_def)

	local desc_dead = def.desc_dead or string.format("%s (dead)", description)
	local image_dead = def.image_dead
		or aus.fname_with_suffix_ext(image, "_dead")
	local dead_def = table.copy(pa.aquatic_life_base_def)
	dead_def.description = desc_dead
	dead_def.drawtype = def.drawtype or base_def.drawtype
	dead_def.waving = 0
	dead_def.tiles = {image_dead}
	dead_def.inventory_image = image_dead
	dead_def.wield_image = image_dead
	dead_def.walkable = false
	dead_def.damage_per_second = 1
	dead_def.liquid_move_physics = true
	dead_def.drowning = 0
	dead_def.move_resistance = 7
	-- All dead corals are hard.. I think
	dead_def.groups = {snappy=3, attached_node=1, sponge=1}
	dead_def.sounds = default.node_sound_leaves_defaults()
	minetest.register_node(nn_dead, dead_def)

	local stone_def = table.copy(pa.stone_basedef)
	stone_def.description = string.format("%s stone", description)
	stone_def.inventory_image = stone_def.inventory_image .. image
	stone_def.on_timer = pa.stone_basedef_on_timer_closure(nodename)
	stone_def.on_punch = aus.timer_info
	minetest.register_node(nodename_stone, stone_def)

	if not minetest.get_modpath("ethereal") then return end

	minetest.register_craft({
		type = "shapeless",
		output = "ethereal:sponge",
		recipe = {
			nn_dead, nn_dead, nn_dead, nn_dead
		},
	})

end

pa.register_sponge({
	nodename = "australia:tube_sponge",
	nodename_stone = "australia:coral_stone_tube_sponge",
	description = "Pipestela candelabra: Bob Marley Sponge",
	image = "aus_tube_sponge.png",
	hard = false,
})
