-- mods/australia/biome_mangroves.lua

local biome_name = "mangroves"
local node_top = "australia:mangrove_mud"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 3,
	node_filler = "default:clay",
	depth_filler = 1,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = -2,
	y_max = 3,
	heat_point = 80,
	humidity_point = 80,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs



--
-- Decorations
--

	-- Mangrove Fern
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top,
		"default:dirt",
		"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.2,
	biomes = {biome_name},
	y_min = 2,
	y_max = 3,
	decoration = "australia:mangrove_fern",
})

	-- Mangrove Lily
minetest.register_decoration({
	deco_type = "simple",
	place_on = {node_top,
		"default:dirt",
		"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.1,
	biomes = {biome_name},
	y_min = 2,
	y_max = 3,
	decoration = "australia:mangrove_lily",
})

	-- Mangrove Palm
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {node_top,
		"default:dirt"},
	sidelen = 80,
	fill_ratio = 0.3,
	biomes = {biome_name},
	y_min = 1,
	y_max = 3,
	schematic = {
		size = { x = 1, y = 4, z = 1},
		data = {
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:mangrove_palm_trunk", param1 = 255, param2 = 0 },
			{ name = "australia:mangrove_palm_leaf_bot", param1 = 255, param2 = 0 },
			{ name = "australia:mangrove_palm_leaf_top", param1 = 255, param2 = 0 },
		},
	},
	flags = "force_placement",
})




--
-- Trees
--

	-- Grey Mangrove
aus.register_schem_to_biome("grey_mangrove_tree", biome_name, {
	place_on = {node_top, "default:dirt", "default:sand"},
	y_min = -2,
	y_max = 3,
	const_fill_ratio = 0.003
})

	-- Mangrove Apple
aus.register_schem_to_biome("mangrove_apple_tree", biome_name, {
	place_on = {node_top, "default:dirt", "default:sand"},
	y_min = 0,
	y_max = 3,
	fill_ratio_divisor = 5000,
})

	-- Stilted Mangrove
aus.register_schem_to_biome("stilted_mangrove_tree", biome_name, {
	place_on = {node_top, "default:dirt", "default:sand"},
	y_min = -2,
	y_max = 3,
	const_fill_ratio = 0.003
})
