-- mods/australia/biome_gulf_of_carpentaria.lua

local biome_name = "gulf_of_carpentaria"
local node_top = "default:dirt_with_dry_grass"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 2,
	node_stone = "default:sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = 4,
	y_max = 35,
	heat_point = 75,
	humidity_point = 55,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

	-- Copper
minetest.register_ore({
	ore_type        = "blob",
	ore             = "default:stone_with_copper",
	wherein         = {"default:stone"},
	clust_scarcity  = 44 * 44 * 44,
	clust_size      = 8,
	biomes          = {"gulf_of_carpentaria"},
	y_min           = -64,
	y_max           = 0,
	noise_threshold = 1,
	noise_params    = {
		offset = 0,
		scale = 3,
		spread = {x = 16, y = 16, z = 16},
		seed = 890,
		octaves = 3,
		persist = 0.6
	},
})



--
-- Decorations
--

	-- Grasses
aus.biome_register_grass_decorations(
	{
		{0,      0.06,  3},
		{0.015,  0.045, 2},
		{0.03,   0.03,  1},
	},
	biome_name, node_top, "default:grass_", 4, 9
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


	-- Mitchell Grass
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {biome_name},
	y_min = 12,
	y_max = 35,
	decoration = "australia:mitchell_grass",
})



--
-- Trees
--

	-- Cloncurry Box
aus.register_schem_to_biome("cloncurry_box_tree", biome_name, {
	place_on = {node_top},
	y_min = 6,
	y_max = 35,
	fill_ratio_divisor = 10000,
})

	-- Darwin Woollybutt
aus.register_schem_to_biome("darwin_woollybutt_tree", "gulf_of_carpentaria", {
	place_on = {node_top},
	y_min = 8,
	y_max = 35,
	fill_ratio_divisor = 12000,
})

	-- River Oak (small)
aus.register_schem_to_biome("river_oak_small_tree", "gulf_of_carpentaria", {
	place_on = {node_top},
	y_min = 12,
	y_max = 35,
	fill_ratio_divisor = 12000,
})
