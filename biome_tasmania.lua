-- mods/australia/biome_tasmania.lua

local biome_name = "tasmania"
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
	y_min = 36,
	y_max = aus.biome_ymax() - 10,
	heat_point = 17,
	humidity_point = 85,
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
	y_min = 36,
	y_max = 70,
	fill_ratio = 0.006,
	biomes = {"tasmania"},
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

	-- Small Tree Fern
local f1 = { name = "australia:fern_trunk" }
local f2 = { name = "australia:tree_fern_leaves_02" }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {node_top},
	y_min = 36,
	y_max = 80,
	fill_ratio = 0.01,
	biomes = {biome_name},
	schematic = {
		size = {y = 4, x = 1, z = 1},
	data = {
			f1, f1, f1, f2, 
			},
		yslice_prob = {},
	},
})

	-- Ruddy Ground Fern
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x = 200, y = 200, z = 200},
		seed = 80,
		octaves = 3,
		persist = 0.66
	},
	biomes = {biome_name},
	y_min = 36,
	y_max = 160,
	decoration = "australia:fern",
})

	-- Sickle Fern
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.008,
		spread = {x = 200, y = 200, z = 200},
		seed = 81,
		octaves = 3,
		persist = 0.66
	},
	biomes = {biome_name},
	y_min = 36,
	y_max = 140,
	decoration = "australia:small_fern",
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
	biome_name, node_top, "default:grass_", 3, 31000
)



--
-- Moss
--

minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.9,
	biomes = {biome_name},
	y_min = 8,
	y_max = 31000,
	decoration = "australia:moss",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.02,
	biomes = {biome_name},
	y_min = 8,
	y_max = 31000,
	decoration = "australia:moss_with_fungus",
})



--
-- Mushrooms
--

	-- Brown Mushroom
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x = 200, y = 200, z = 200},
		seed = 55,
		octaves = 3,
		persist = 0.66
	},
	biomes = {biome_name},
	y_min = 7,
	y_max = 31000,
	decoration = "flowers:mushroom_brown",
})

	-- Red Mushroom
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x = 200, y = 200, z = 200},
		seed = 56,
		octaves = 3,
		persist = 0.66
	},
	biomes = {biome_name},
	y_min = 7,
	y_max = 31000,
	decoration = "flowers:mushroom_red",
})



--
-- Trees
--

	-- Blue Gum
aus.register_schem_to_biome("blue_gum_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 170,
	fill_ratio_divisor = 15000,
})

	-- Celery-top Pine
aus.register_schem_to_biome("celery_top_pine_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 180,
	fill_ratio_divisor = 8000,
})

	-- Huon Pine
aus.register_schem_to_biome("huon_pine_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 150,
	fill_ratio_divisor = 15000,
})

	-- Southern Sassafras
aus.register_schem_to_biome("southern_sassafras_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 170,
	fill_ratio_divisor = 8000,
})

	-- Swamp Gum
aus.register_schem_to_biome("swamp_gum_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 120,
	fill_ratio_divisor = 10000,
})

	-- Tasmanian Myrtle
aus.register_schem_to_biome("tasmanian_myrtle_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 150,
	fill_ratio_divisor = 10000,
})
