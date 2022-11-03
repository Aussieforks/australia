-- mods/australia/biome_timor_sea.lua

local biome_name = "timor_sea"
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
	heat_point = 80,
	humidity_point = 90,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:submarine",
	wherein        = node_top,
	clust_scarcity = 80*80*80,
	clust_num_ores = 1,
	clust_size     = 12,
	biomes         = {"timor_sea"},
	y_min     = -64,
	y_max     = -8,
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
	biome_name, node_top, "default:grass_", 3, 3
)

	-- Narrowleaf Seagrass
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.02,
	biomes = {biome_name},
	y_min     = -10,
	y_max     = -2,
	decoration = "australia:sea_grass",
	flags = "force_placement",
})
