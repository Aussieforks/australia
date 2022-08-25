-- mods/australia/biome_far_north_queensland.lua

local biome_name = "far_north_queensland"
local node_top = "default:dirt_with_grass"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "",
	y_min = 4,
	y_max = 35,
	heat_point = 75,
	humidity_point = 90,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs



--
-- Ferns
--

	-- Big Tree Fern
local n1 = { name = "air", prob = 0 }
local n2 = { name = "australia:tree_fern_leaf_big_end" }
local n3 = { name = "australia:tree_fern_leaf_big" }
local n4 = { name = "australia:fern_trunk_big" }
local n5 = { name = "australia:tree_fern_leaf_big_end", param2 = 1 }
local n6 = { name = "australia:fern_trunk_big_top" }
local n7 = { name = "australia:tree_fern_leaf_big_end", param2 = 3 }
local n8 = { name = "australia:tree_fern_leaves_giant" }
local n9 = { name = "australia:tree_fern_leaf_big_end", param2 = 2 }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = 6,
	y_max = 20,
	fill_ratio = 0.003,
	biomes = {"far_north_queensland"},
	schematic = {
		size = {y = 7, x = 9, z = 9},
	data = {
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, 
			n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n5, 
			n1, n1, n1, n6, n1, n1, n1, n7, n1, n3, n1, n3, n8, n3, n1, n3, n1, 
			n1, n1, n3, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n9, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, 
			},
		yslice_prob = {},
	},
	flags = "place_center_x, place_center_z",
})

	-- Giant Tree Fern
local n1 = { name = "air", prob = 0 }
local n2 = { name = "australia:tree_fern_leaf_big_end" }
local n3 = { name = "australia:tree_fern_leaf_big" }
local n4 = { name = "australia:fern_trunk_big" }
local n5 = { name = "australia:tree_fern_leaf_big_end", param2 = 1 }
local n6 = { name = "australia:fern_trunk_big_top" }
local n7 = { name = "australia:tree_fern_leaf_big_end", param2 = 3 }
local n8 = { name = "australia:tree_fern_leaves_giant" }
local n9 = { name = "australia:tree_fern_leaf_big_end", param2 = 2 }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = 7,
	y_max = 18,
	fill_ratio = 0.005,
	biomes = {"far_north_queensland"},
	schematic = {
		size = {y = 13, x = 9, z = 9},
	data = {
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, 
			n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, 
			n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, 
			n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, 
			n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, 
			n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n5, n1, n1, 
			n1, n6, n1, n1, n1, n7, n1, n3, n1, n3, n8, n3, n1, n3, n1, n1, n1, 
			n3, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n9, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			},
		yslice_prob = {},
	},
	flags = "place_center_x, place_center_z",
})

	-- Small Tree Fern
local f1 = { name = "australia:fern_trunk" }
local f2 = { name = "australia:tree_fern_leaves_02" }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = 6,
	y_max = 21,
	fill_ratio = 0.01,
	biomes = {"far_north_queensland"},
	schematic = {
		size = {y = 4, x = 1, z = 1},
	data = {
			f1, f1, f1, f2, 
			},
		yslice_prob = {},
	},
})



--
-- Decorations
--
	-- Grasses
aus.biome_register_grass_decorations(
	{
		{-0.03,  0.09,  5},
		{-0.015, 0.075, 4},
		{0,      0.06,  3},
		{0.015,  0.045, 2},
		{0.03,   0.03,  1},
	},
	biome_name, node_top, "default:grass_", 5, 35
)

	-- Dry grasses
aus.biome_register_grass_decorations(
	{
		{0.01, 0.05,  5},
		{0.03, 0.03,  4},
	},
	biome_name, node_top, "default:dry_grass_", 22, 35
)


--
-- Ferns
--




--
-- Trees
--

	-- Daintree Stringybark
aus.register_schem_to_biome("daintree_stringybark_tree", biome_name, {
	place_on = {node_top},
	y_min = 25,
	y_max = 35,
	fill_ratio_divisor = 12000,
})

	-- Darwin Woollybutt
aus.register_schem_to_biome("darwin_woollybutt_tree", "far_north_queensland", {
	place_on = {"default:dirt_with_grass"},
	y_min = 25,
	y_max = 35,
	fill_ratio_divisor = 12000,
})

	-- Australian Fan Palm
aus.register_schem_to_biome("fan_palm_tree", biome_name, {
	place_on = {node_top},
	y_min = 5,
	y_max = 20,
	fill_ratio_divisor = 300,
})

	-- Lemon Eucalyptus
aus.register_schem_to_biome("lemon_eucalyptus_tree", biome_name, {
	place_on = {node_top},
	y_min = 20,
	y_max = 35,
	fill_ratio_divisor = 12000,
})

	-- Lilly Pilly
aus.register_schem_to_biome("lilly_pilly_tree", biome_name, {
	place_on = {node_top},
	y_min = 20,
	y_max = 35,
	fill_ratio_divisor = 12000,
})

	-- Merbau
aus.register_schem_to_biome("merbau_tree", biome_name, {
	place_on = {node_top},
	y_min = 6,
	y_max = 25,
	fill_ratio_divisor = 6000,
})

	-- River Oak
aus.register_schem_to_biome("river_oak_big_tree", biome_name, {
	place_on = {"default:dirt_with_grass"},
	y_min = 25,
	y_max = 35,
	fill_ratio_divisor = 12000,
})
