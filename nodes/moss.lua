--
-- Moss
--

minetest.register_node("australia:moss", {
	description = "Moss",
	drawtype = "nodebox",
	tiles = {"aus_moss.png"},
	inventory_image = "aus_moss.png",
	wield_image = "aus_moss.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
	},
	groups = {snappy = 3, flammable = 3, flora = 1},
	sounds = default.node_sound_leaves_defaults(),
    use_texture_alpha = "clip",
})

minetest.register_node("australia:moss_with_fungus", {
	description = "Moss with Fungus",
	drawtype = "nodebox",
	tiles = {"aus_moss_fungus.png"},
	inventory_image = "aus_moss_fungus.png",
	wield_image = "aus_moss_fungus.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
	},
	groups = {snappy = 3, flammable = 3, flora = 1},
	sounds = default.node_sound_leaves_defaults(),
    use_texture_alpha = "clip",
})
