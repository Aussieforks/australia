-- FIXME: Sponges are soft when dead, implement aus.register_sponge
local pa = aus.plantlife_aquatic

-- The code would mostly duplicate the coral code, so I have decided to use an
-- override until it seems worth forking the coral code or refactoring to allow
-- further subclassing.
function pa.register_sponge(def)
	pa.register_coral(def)

	local nn_bleached = def.nodename_dead or def.nodename.."_bleached"
	minetest.override_item(nn_bleached, {
		groups = {cracky=0, stone=0, coral=1, attached_node=1, oddly_breakable_by_hand=1},
		sounds = default.node_sound_leaves_defaults(),
	})
end

pa.register_sponge({
	nodename = "australia:tube_sponge",
	nodename_stone = "australia:coral_stone_tube_sponge",
	description = "Pipestela candelabra: Bob Marley Sponge",
	image = "aus_tube_sponge.png",
	hard = false,
})
