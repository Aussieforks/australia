-- mods/australia/biome_eastern_coasts.lua

local biome_name = "eastern_coasts"
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
	node_river_water = "australia:muddy_river_water_source",
	y_min = 4,
	y_max = 35,
	heat_point = 35,
	humidity_point = 60,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

	-- Bluestone (Basalt)
minetest.register_ore({
	ore_type        = "blob",
	ore             = "australia:bluestone",
	wherein         = {"default:stone"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 8,
	biomes          = {"eastern_coasts"},
	y_min           = 4,
	y_max           = 35,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 677,
		octaves = 1,
		persist = 0.0
	},
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_coal",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 24,
	clust_size     = 5,
	biomes         = {"eastern_coasts"},
	y_min          = -64,
	y_max          = 35,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:coalblock",
	wherein        = "default:stone",
	clust_scarcity = 48 * 48 * 48,
	clust_num_ores = 8,
	clust_size     = 3,
	biomes         = {"eastern_coasts"},
	y_min          = -64,
	y_max          = 35,
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
	biome_name, node_top, "default:grass_", 4, 35
)

	-- Waratah
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.005,
	biomes = {"eastern_coasts"},
	y_min = 6,
	y_max = 35,
	schematic = {
		size = { x = 2, y = 4, z = 2},
		data = {
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
		},
	},
	flags = "force_placement",
})



--
-- Trees
--

	-- Black Wattle
aus.register_schem_to_biome("black_wattle_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- Australian Cherry
aus.register_schem_to_biome("cherry_tree", biome_name, {
	place_on = {"default:dirt_with_grass"},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 15000,
})
	-- Coast Banksia (big)
aus.register_schem_to_biome("coast_banksia_big_tree", biome_name, {
	place_on = {node_top},
	y_min = 12,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- Coast Banksia (small)
aus.register_schem_to_biome("coast_banksia_small_tree", biome_name, {
	place_on = {node_top},
	y_min = 6,
	y_max = 10,
	fill_ratio_divisor = 12000,
})

	-- Coolabah Tree
aus.register_schem_to_biome("coolabah_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 20000,
})

	-- Illawarra Flame Tree
aus.register_schem_to_biome("illawarra_flame_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- Lemon Myrtle
aus.register_schem_to_biome("lemon_myrtle_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- Lilly Pilly
aus.register_schem_to_biome("lilly_pilly_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 12000,
})

	-- Macadamia Tree
aus.register_schem_to_biome("macadamia_tree", biome_name, {
	place_on = {node_top},
	y_min = 8,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- Moreton Bay Fig
aus.register_schem_to_biome("moreton_bay_fig_tree", biome_name, {
	place_on = {node_top},
	y_min = 8,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- Paperbark Tree
aus.register_schem_to_biome("paperbark_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- River Oak (big)
aus.register_schem_to_biome("river_oak_big_tree", biome_name, {
	place_on = {node_top},
	y_min = 25,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- River Red Gum
aus.register_schem_to_biome("river_red_gum_tree", biome_name, {
	place_on = {node_top},
	y_min = 25,
	y_max = 35,
	fill_ratio_divisor = 20000,
})

	-- Scribbly Gum
aus.register_schem_to_biome("scribbly_gum_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 12000,
})

	-- Tea Tree
aus.register_schem_to_biome("tea_tree_tree", biome_name, {
	place_on = {"default:dirt_with_grass"},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 12000,
})
