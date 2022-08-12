-- Ecklonia radiata: Common Kelp
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
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Macrocystis pyrifera: Giant Kelp
minetest.register_node("australia:kelp_giant_brown", {
	description = "Giant Kelp ",
	drawtype = "plantlike",
	tiles = {"aus_kelp_giant_brown.png"},
	inventory_image = "aus_kelp_giant_brown.png",
	wield_image = "aus_kelp_giant_brown.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1)
})

minetest.register_node("australia:kelp_giant_brown_middle", {
	description = "Giant Kelp middle",
	drawtype = "plantlike",
	tiles = {"aus_kelp_giant_brown_middle.png"},
	inventory_image = "aus_kelp_giant_brown_middle.png",
	wield_image = "aus_kelp_giant_brown_middle.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	drop = "australia:kelp_giant_brown",
	sounds = default.node_sound_leaves_defaults(),
})

-- Dipsastraea speciosa: Brain Coral
minetest.register_node("australia:brain_coral", {
	description = "Dipsastraea speciosa: Brain Coral",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"aus_brain_coral.png",
		"aus_brain_coral.png",
		"aus_brain_coral.png",
		"aus_brain_coral.png",
		"aus_brain_coral.png",
		"aus_brain_coral.png"
	},
	inventory_image = "aus_brain_coral.png",
	wield_image = "aus_brain_coral.png",
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, 0.4375, 0.1875},
			{-0.25, -0.5, -0.25, 0.25, 0.375, 0.25},
			{-0.3125, -0.5, -0.3125, 0.3125, 0.3125, 0.3125},
			{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375},
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.1875, 0.4375},
			{-0.5, -0.375, -0.5, 0.5, 0.125, 0.5},
		}
	},
})

-- Pocillopora damicornis: Cauliflower Coral (brown)
minetest.register_node("australia:cauliflower_coral_brown", {
	description = "Pocillopora damicornis: Cauliflower Coral",
	drawtype = "plantlike",
	visual_scale = 0.75,
	tiles = { "aus_cauliflower_coral_brown.png"},
	inventory_image = "aus_cauliflower_coral_brown.png",
	wield_image = "aus_cauliflower_coral_brown.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Pocillopora damicornis: Cauliflower Coral (green)
minetest.register_node("australia:cauliflower_coral_green", {
	description = "Pocillopora damicornis: Cauliflower Coral",
	drawtype = "plantlike",
	visual_scale = 0.75,
	tiles = { "aus_cauliflower_coral_green.png"},
	inventory_image = "aus_cauliflower_coral_green.png",
	wield_image = "aus_cauliflower_coral_green.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Pocillopora damicornis: Cauliflower Coral (pink)
minetest.register_node("australia:cauliflower_coral_pink", {
	description = "Pocillopora damicornis: Cauliflower Coral",
	drawtype = "plantlike",
	visual_scale = 0.75,
	tiles = { "aus_cauliflower_coral_pink.png"},
	inventory_image = "aus_cauliflower_coral_pink.png",
	wield_image = "aus_cauliflower_coral_pink.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Acropora millepora: Cluster Coral (green)
minetest.register_node("australia:cluster_coral_green", {
	description = "Acropora millepora: Cluster Coral",
	drawtype = "plantlike",
	tiles = {"aus_cluster_coral_green.png"},
	inventory_image = "aus_cluster_coral_green.png",
	wield_image = "aus_cluster_coral_green.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Acropora millepora: Cluster Coral (orange)
minetest.register_node("australia:cluster_coral_orange", {
	description = "Acropora millepora: Cluster Coral",
	drawtype = "plantlike",
	tiles = {"aus_cluster_coral_orange.png"},
	inventory_image = "aus_cluster_coral_orange.png",
	wield_image = "aus_cluster_coral_orange.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Acropora millepora: Cluster Coral (purple),g
minetest.register_node("australia:cluster_coral_purple", {
	description = "Acropora millepora: Cluster Coral",
	drawtype = "plantlike",
	tiles = {"aus_cluster_coral_purple.png"},
	inventory_image = "aus_cluster_coral_purple.png",
	wield_image = "aus_cluster_coral_purple.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Acropora cervicornis: Staghorn Coral (blue),g
minetest.register_node("australia:staghorn_coral_blue", {
	description = "Acropora cervicornis: Staghorn Coral",
	drawtype = "plantlike",
	tiles = {"aus_staghorn_coral_blue.png"},
	inventory_image = "aus_staghorn_coral_blue.png",
	wield_image = "aus_staghorn_coral_blue.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Acropora cervicornis: Staghorn Coral (pink),g
minetest.register_node("australia:staghorn_coral_pink", {
	description = "Acropora cervicornis: Staghorn Coral",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_staghorn_coral_pink.png"},
	inventory_image = "aus_staghorn_coral_pink.png",
	wield_image = "aus_staghorn_coral_pink.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Acropora cervicornis: Staghorn Coral (purple),g
minetest.register_node("australia:staghorn_coral_purple", {
	description = "Acropora cervicornis: Staghorn Coral",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_staghorn_coral_purple.png"},
	inventory_image = "aus_staghorn_coral_purple.png",
	wield_image = "aus_staghorn_coral_purple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Acropora cervicornis: Staghorn Coral (yellow),g
minetest.register_node("australia:staghorn_coral_yellow", {
	description = "Acropora cervicornis: Staghorn Coral",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_staghorn_coral_yellow.png"},
	inventory_image = "aus_staghorn_coral_yellow.png",
	wield_image = "aus_staghorn_coral_yellow.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Acabaria sp.: Sea Fan,g
minetest.register_node("australia:seafan_coral", {
	description = "Acabaria sp.: Sea Fan",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_seafan_coral.png"},
	inventory_image = "aus_seafan_coral.png",
	wield_image = "aus_seafan_coral.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy = 3, coral = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Euphyllia ancora: Hammer coral,g
minetest.register_node("australia:hammer_coral", {
	description = "Euphyllia ancora: Hammer coral",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_hammer_coral.png"},
	inventory_image = "aus_hammer_coral.png",
	wield_image = "aus_hammer_coral.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy = 3, coral = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Pipestela candelabra: Bob Marley Sponge,g
minetest.register_node("australia:tube_sponge", {
	description = "Pipestela candelabra: Bob Marley Sponge",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_tube_sponge.png"},
	inventory_image = "aus_tube_sponge.png",
	wield_image = "aus_tube_sponge.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy = 3, coral = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

-- Halodule uninervis: Narrowleaf Seagrass,g
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
