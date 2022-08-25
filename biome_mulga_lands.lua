-- mods/australia/biome_mulga_lands.lua

local biome_name = "mulga_lands"
local node_top = "default:dirt_with_dry_grass"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = 36,
	y_max = aus.biome_ymax(),
	heat_point = 75,
	humidity_point = 45,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs



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
	biome_name, node_top, "default:dry_grass_", 36, 190
)



--
-- Trees
--

	-- Coolabah Tree
aus.register_schem_to_biome("coolabah_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 140,
	fill_ratio_divisor = 20000,
})

	-- Desert Quandong
aus.register_schem_to_biome("quandong_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 150,
	fill_ratio_divisor = 15000,
})

	-- Mulga Tree
aus.register_schem_to_biome("mulga_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 150,
	fill_ratio_divisor = 4000,
})

	-- River Oak
aus.register_schem_to_biome("river_oak_big_tree", biome_name, {
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

	-- Shoestring Acacia
aus.register_schem_to_biome("shoestring_acacia_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 150,
	fill_ratio_divisor = 12000,
})
