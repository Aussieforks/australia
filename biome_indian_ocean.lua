-- mods/australia/biome_indian_ocean.lua

local biome_name = "indian_ocean"
local node_top = "australia:sand_top"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 1,
	node_filler = "default:sandstone",
	depth_filler = 3,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "",
	y_min = -64,
	y_max = 3,
	heat_point = 60,
	humidity_point = 50,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:stone_kelp_brown",
	wherein        = node_top,
	clust_scarcity = 9*9*9,
	clust_num_ores = 25,
	clust_size     = 6,
	biomes         = {"indian_ocean"},
	y_min     = -10,
	y_max     = -3,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:woodship",
	wherein        = node_top,
	clust_scarcity = 30*30*30,
	clust_num_ores = 1,
	clust_size     = 12,
	biomes         = {"indian_ocean"},
	y_min     = -64,
	y_max     = -6,
})



--
-- Decorations
--
	-- Grasses
aus.biome_register_grass_decorations(
	{
		{0.015,  0.045, 2},
		{0.03,   0.03,  1},
	},
	biome_name, node_top, "default:grass_", 3, 3
)

	-- Dry grasses
aus.biome_register_grass_decorations(
	{
		{0.01, 0.05,  5},
		{0.03, 0.03,  4},
		{0.05, 0.01,  3},
	},
	biome_name, node_top, "default:dry_grass_", 3,3
)

	-- Narrowleaf Seagrass
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.01,
	biomes = {biome_name},
	y_min     = -10,
	y_max     = -2,
	decoration = "australia:sea_grass",
	flags = "force_placement",
})
