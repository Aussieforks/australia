if not minetest.get_modpath("walls") then return end

walls.register("australia:wall_bluestone_cobble", "Bluestone Cobble Wall",
	{"aus_bluestone_cobble.png"}, "australia:bluestone_cobble",
	default.node_sound_stone_defaults())

walls.register("australia:wall_bluestone_brick", "Bluestone Brick Wall",
	{"aus_bluestone_brick.png"}, "australia:bluestone_brick",
	default.node_sound_stone_defaults())

walls.register("australia:wall_red_cobble", "Red Cobblestone Wall",
	{"aus_red_cobble.png"}, "australia:red_cobble",
	default.node_sound_stone_defaults())

walls.register("australia:wall_red_brick", "Red Stone Brick Wall",
	{"aus_red_stonebrick.png"}, "australia:red_stonebrick",
	default.node_sound_stone_defaults())
