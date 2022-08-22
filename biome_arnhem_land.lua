-- mods/australia/biome_arnhem_land.lua

local biome_name = "arnhem_land"
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
	heat_point = 60,
	humidity_point = 80,
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
		clust_scarcity  = 24 * 24 * 24,
		clust_num_ores  = 4,
		clust_size      = 3,
		biomes          = {"arnhem_land"},
		y_min           = -64,
		y_max           = 35,
		noise_params    = {
			offset = 0,
			scale = 1,
			spread = {x = 100, y = 100, z = 100},
			seed = 420,
			octaves = 3,
			persist = 0.7
			},
		noise_threshold = 0.6,
	})
end



--
-- Decorations
--

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

--
-- Trees
--

aus.register_schem_to_biome("darwin_woollybutt_tree", biome_name, {
	place_on = {"default:dirt_with_grass"},
	y_min = 8,
	y_max = 35,
	fill_ratio = 10000,
})

aus.register_schem_to_biome("river_oak_small_tree", biome_name, {
	place_on = {"default:dirt_with_grass"},
	y_min = 12,
	y_max = 35,
	fill_ratio = 12000,
})
