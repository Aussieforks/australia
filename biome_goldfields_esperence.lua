-- mods/australia/biome_goldfields_esperence.lua

local biome_name = "goldfields_esperence"
local node_top = "default:desert_sand"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 2,
	node_filler = "default:sandstone",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "default:dirt_with_dry_grass",
	y_min = 4,
	y_max = 35,
	heat_point = 60,
	humidity_point = 20,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

	-- Gold
minetest.register_ore({
	ore_type        = "blob",
	ore             = "default:stone_with_gold",
	wherein         = {"default:stone"},
	clust_scarcity  = 36 * 36 * 36,
	clust_size      = 8,
	biomes          = {"goldfields_esperence"},
	y_min           = -64,
	y_max           = 0,
	noise_threshold = 0.8,
	noise_params    = {
		offset = 0,
		scale = 3,
		spread = {x = 16, y = 16, z = 16},
		seed = 891,
		octaves = 3,
		persist = 0.6
	},
})



--
-- Decorations
--
	-- Dry grasses
aus.biome_register_grass_decorations(
	{
		{0.01, 0.05,  5},
		{0.03, 0.03,  4},
		{0.05, 0.01,  3},
		{0.07, -0.01, 2},
		{0.09, -0.03, 1},
	},
	biome_name, node_top, "default:dry_grass_", 5, 35
)


	-- Spinifex
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {biome_name},
	y_min = 6,
	y_max = 35,
	decoration = "australia:spinifex",
})



--
-- Trees
--

	-- Desert Quandong
aus.register_schem_to_biome("quandong_tree", biome_name, {
	place_on = {node_top},
	y_min = 6,
	y_max = 35,
	fill_ratio = 15000,
})

