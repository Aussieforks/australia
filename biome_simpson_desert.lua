-- mods/australia/biome_simpson_desert.lua

local biome_name = "simpson_desert"
local node_top = "australia:red_sand"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 3,
	node_filler = "australia:red_stone",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = 36,
	y_max = aus.biome_ymax(),
	heat_point = 85,
	humidity_point = 10,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs



--
-- Trees
--

	-- Coolabah Tree
aus.register_schem_to_biome("coolabah_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 150,
	fill_ratio_divisor = 20000,
})

	-- Desert Quandong
aus.register_schem_to_biome("quandong_tree", biome_name, {
	place_on = {node_top},
	y_min = 36,
	y_max = 130,
	fill_ratio_divisor = 15000,
})

