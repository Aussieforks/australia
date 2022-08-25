-- mods/australia/biome_central_australia.lua

local biome_name = "central_australia"
local node_top = "australia:red_dirt"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 1,
	node_filler = "australia:red_stone",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = 36,
	y_max = aus.biome_ymax(),
	heat_point = 80,
	humidity_point = 25,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

-- Uranium from Technic modpack: technic_worldgen mod
if minetest.get_modpath("technic_worldgen") then
	minetest.register_ore({
		ore_type        = "scatter",
		ore             = "technic:mineral_uranium",
		wherein         = "default:stone",
		clust_scarcity  = 20 * 20 * 20,
		clust_num_ores  = 6,
		clust_size      = 4,
		biomes          = {"central_australia"},
		y_min           = -64,
		y_max           = 64,
		noise_params    = {
			offset = 0,
			scale = 1,
			spread = {x = 100, y = 100, z = 100},
			seed = 421,
			octaves = 3,
			persist = 0.7
			},
		noise_threshold = 0.6,
	})
end



--
-- Decorations
--

	-- Dry grasses
aus.biome_register_grass_decorations(
	{
		{0.05,  0.01, 3},
		{0.07, -0.01, 2},
		{0.09, -0.03, 1}
	},
	biome_name, node_top, "default:dry_grass_", 36, 190
)


	-- Mitchell Grass
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {biome_name},
	y_min = 37,
	y_max = 180,
	decoration = "australia:mitchell_grass",
})

	-- Spinifex
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {biome_name},
	y_min = 37,
	y_max = 170,
	decoration = "australia:spinifex",
})



--
-- Trees
--
	-- Coolabah
aus.register_schem_to_biome("coolabah_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 140,
	fill_ratio_divisor = 20000,
})

	-- Desert Oak
aus.register_schem_to_biome("desert_oak_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 140,
	fill_ratio_divisor = 15000,
})

	-- Desert Quandong
aus.register_schem_to_biome("quandong_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 130,
	fill_ratio_divisor = 15000,
})

	-- Wirewood
aus.register_schem_to_biome("wirewood_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 150,
	fill_ratio_divisor = 12000,
})

	-- River Red Gum
aus.register_schem_to_biome("river_red_gum_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 140,
	fill_ratio_divisor = 20000,
})

	-- Sugar Gum
aus.register_schem_to_biome("sugar_gum_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 140,
	fill_ratio_divisor = 20000,
})

