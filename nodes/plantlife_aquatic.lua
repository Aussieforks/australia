-- Macrocystis pyrifera: Giant Kelp
minetest.register_node("australia:kelp_giant_brown", {
	description = "Macrocystis pyrifera: Giant Kelp",
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
	groups = {snappy=3, seaplants=1, sea=1, food_seaweed=1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1),
})

minetest.register_node("australia:stone_kelp_giant_brown", {
	description = "Macrocystis pyrifera: Giant Kelp stone",
	tiles = {"aus_coral_stone.png"},
	inventory_image = "aus_coral_stone.png^aus_kelp_giant_brown.png",
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
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
	groups = {snappy=3, seaplants=1, sea=1, not_in_creative_inventory=1},
	drop = "australia:kelp_giant_brown",
	sounds = default.node_sound_leaves_defaults(),
	on_destruct = function(pos)
		local above = vector.new(pos.x, pos.y+1, pos.z)
		if minetest.get_node(above).name:match("australia:kelp_giant_brown") then
			minetest.dig_node(above)
		end
	end,
})

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

-- ABMs

minetest.register_abm({
	nodenames = {"australia:stone_kelp_brown"},
	interval = 15,
	chance = 5,
	action = function(pos, node, active_object_count, active_object_count_wider)
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
})

minetest.register_abm({
	nodenames = {"australia:stone_kelp_giant_brown"},
	interval = 12,
	chance = 10,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node(yp).name == "default:water_source" or
		minetest.get_node(yp).name == "australia:water_source") then
			pos.y = pos.y + 1
			minetest.add_node(pos, {name = "australia:kelp_giant_brown"}) else
			return
		end
	end
})
