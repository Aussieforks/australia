-- mods/australia/biome_kimberley.lua

local biome_name = "kimberley"
local node_top = "australia:red_dirt"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 2,
	node_filler = "default:sandstone",
	depth_filler = 3,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = 4,
	y_max = 35,
	heat_point = 80,
	humidity_point = 75,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_diamond",
	wherein        = "default:stone",
	clust_scarcity = 40 * 40 * 40,
	clust_num_ores = 12,
	clust_size     = 4,
	biomes         = {"kimberley"},
	y_min          = -64,
	y_max          = 35,
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
	biome_name, node_top, "default:grass_", 4, 30
)

	-- Dry grasses
aus.biome_register_grass_decorations(
	{
		{0.01, 0.05,  5},
		{0.03, 0.03,  4},
		{0.05, 0.01,  3},
		{0.07, -0.01, 2},
		{0.09, -0.03, 1},
	},
	biome_name, node_top, "default:dry_grass_", 7, 35
)

--
-- Trees
--

	-- Boab Tree
aus.register_schem_to_biome("boab_tree", biome_name, {
	place_on = {node_top},
	y_min = 9,
	y_max = 35,
	fill_ratio_divisor = 10000,
})

-- Darwin Woollybutt
aus.register_schem_to_biome("darwin_woollybutt_tree", "kimberley", {
	place_on = {node_top},
	y_min = 12,
	y_max = 35,
	fill_ratio_divisor = 15000,
})

	-- Swamp Bloodwood
aus.register_schem_to_biome("swamp_bloodwood_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 35,
	fill_ratio_divisor = 10000
})
