-- mods/australia/biome_jarrah_karri_forests.lua

local biome_name = "jarrah_karri_forests"
local node_top = "default:dirt_with_grass"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_stone = "default:sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = 4,
	y_max = 35,
	heat_point = 20,
	humidity_point = 50,
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
	wherein         = {"default:stone", "default:sandstone"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 8,
	biomes          = {"jarrah_karri_forests"},
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



--
-- Decorations
--

	-- Grasses
aus.biome_register_grass_decorations(
	{
		{0.015,  0.045, 2},
		{0.03,   0.03,  1},
	},
	biome_name, node_top, "default:grass_", 5, 31000
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
	biome_name, node_top, "default:dry_grass_", 5, 31000
)

	-- Couch Honeypot
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.02,
	biomes = {biome_name},
	decoration = "australia:couch_honeypot",
})


--
-- Trees
--

	-- Bull Banksia
aus.register_schem_to_biome("bull_banksia_tree", biome_name, {
	place_on = {node_top},
	y_min = 8,
	y_max = 35,
	fill_ratio_divisor = 12000,
})

	-- Coolabah Tree
aus.register_schem_to_biome("coolabah_tree", biome_name, {
	place_on = {node_top},
	y_min = 8,
	y_max = 35,
	fill_ratio_divisor = 20000,
})

	-- Jarrah
aus.register_schem_to_biome("jarrah_tree", biome_name, {
	place_on = {node_top},
	y_min = 12,
	y_max = 35,
	fill_ratio_divisor = 8000,
})

	-- Karri
aus.register_schem_to_biome("karri_tree", biome_name, {
	place_on = {node_top},
	y_min = 12,
	y_max = 35,
	fill_ratio_divisor = 10000,
})

	-- Marri
aus.register_schem_to_biome("marri_tree", biome_name, {
	place_on = {node_top},
	y_min = 12,
	y_max = 35,
	fill_ratio_divisor = 10000,
})

	-- Rottnest Island Pine
aus.register_schem_to_biome("rottnest_island_pine_tree", biome_name, {
	place_on = {node_top},
	y_min = 6,
	y_max = 20,
	fill_ratio_divisor = 10000,
})

	-- Swamp Paperbark
aus.register_schem_to_biome("swamp_paperbark_tree", biome_name, {
	place_on = {node_top},
	y_min = 7,
	y_max = 25,
	fill_ratio_divisor = 15000,
})
