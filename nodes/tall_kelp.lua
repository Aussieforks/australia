-- aus/nodes/coral.lua
-- Corals and other nodes that grow from stony beds on the sea floor.
local pa = aus.plantlife_aquatic

local growth_targets = pa.growth_targets
local iswater = aus.iswater

local photosynthesis_interval = pa.photosynthesis_interval
local coral_start_timer = pa.start_timer
local coral_grow = pa.grow

-- TODO: Registration function

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
	-- attached_node: Cannot make it attached or adjacent sand will cause
	-- collapse; also punching the middle would cause entire plant collapse.
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

minetest.register_abm({
	nodenames = {"australia:stone_kelp_giant_brown"},
	interval = 12,
	chance = 10,
	action = function(pos)--, node, active_object_count, active_object_count_wider)
		local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node(yp).name == "default:water_source" or
		minetest.get_node(yp).name == "australia:water_source") then
			pos.y = pos.y + 1
			minetest.add_node(pos, {name = "australia:kelp_giant_brown"}) else
			return
		end
	end
})

minetest.register_abm({
	nodenames = {"australia:kelp_giant_brown"},
	interval = 4,
	chance = 2,
	action = function(pos)--, node, active_object_count, active_object_count_wider)
		local below_name = minetest.get_node(vector.new(pos.x, pos.y-1, pos.z)).name
		if not (below_name == "australia:kelp_giant_brown_middle" or
			below_name == "australia:stone_kelp_giant_brown")
		then return end

		local pos_iter = vector.new(pos.x, pos.y+1, pos.z)
		repeat
			--print("pos_iter="..tostring(pos_iter))
			if minetest.get_node(pos_iter).name ~= "default:water_source" then
				return
			end
			pos_iter.y = pos_iter.y + 1
		until pos_iter.y == pos.y + 4

		minetest.set_node(pos, {name = "australia:kelp_giant_brown_middle"})
		pos.y = pos.y + 1
		minetest.set_node(pos, {name = "australia:kelp_giant_brown"})
	end
})
