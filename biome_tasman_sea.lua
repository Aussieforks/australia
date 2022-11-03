-- mods/australia/biome_tasman_sea.lua

local biome_name = "tasman_sea"
local node_top = "default:sand"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "",
	y_min = -64,
	y_max = 3,
	heat_point = 20,
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
	wherein        = "default:sand",
	clust_scarcity = 9*9*9,
	clust_num_ores = 25,
	clust_size     = 6,
	biomes         = {"tasman_sea"},
	y_min     = -10,
	y_max     = -3,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:stone_kelp_giant_brown",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 8,
	biomes         = {"tasman_sea"},
	y_min     = -64,
	y_max     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:woodship",
	wherein        = "default:sand",
	clust_scarcity = 60*60*60,
	clust_num_ores = 1,
	clust_size     = 12,
	biomes         = {"tasman_sea"},
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
		{0.01, 0.05, 5},
		{0.03, 0.03, 4},
		{0.05, 0.01, 3},
	},
	biome_name, node_top, "default:dry_grass_", 3, 3
)
