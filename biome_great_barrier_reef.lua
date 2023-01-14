-- mods/australia/biome_great_barrier_reef.lua

local node_top = "australia:sand_top"

minetest.register_biome({
	name = "great_barrier_reef",
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
	heat_point = 75,
	humidity_point = 75,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_brain",
	wherein        = node_top,
	clust_scarcity = 20*20*20,
	clust_num_ores = 8,
	clust_size     = 3,
	biomes         = {"great_barrier_reef"},
	y_min     = -12,
	y_max     = -3,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_cauliflower_brown",
	wherein        = node_top,
	clust_scarcity = 11*11*11,
	clust_num_ores = 25,
	clust_size     = 8,
	biomes         = {"great_barrier_reef"},
	y_min     = -12,
	y_max     = -4,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_cauliflower_green",
	wherein        = node_top,
	clust_scarcity = 11*11*11,
	clust_num_ores = 25,
	clust_size     = 8,
	biomes         = {"great_barrier_reef"},
	y_min     = -12,
	y_max     = -4,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_cauliflower_pink",
	wherein        = node_top,
	clust_scarcity = 11*11*11,
	clust_num_ores = 25,
	clust_size     = 8,
	biomes         = {"great_barrier_reef"},
	y_min     = -12,
	y_max     = -4,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_cluster_green",
	wherein        = node_top,
	clust_scarcity = 15*15*15,
	clust_num_ores = 20,
	clust_size     = 4,
	biomes         = {"great_barrier_reef"},
	y_min     = -8,
	y_max     = -2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_cluster_orange",
	wherein        = node_top,
	clust_scarcity = 15*15*15,
	clust_num_ores = 20,
	clust_size     = 4,
	biomes         = {"great_barrier_reef"},
	y_min     = -8,
	y_max     = -2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_cluster_purple",
	wherein        = node_top,
	clust_scarcity = 15*15*15,
	clust_num_ores = 20,
	clust_size     = 4,
	biomes         = {"great_barrier_reef"},
	y_min     = -8,
	y_max     = -2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_hammer",
	wherein        = node_top,
	clust_scarcity = 64*64*64,
	clust_num_ores = 20,
	clust_size     = 12,
	biomes         = {"great_barrier_reef"},
	y_min     = -10,
	y_max     = -2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_seafan",
	wherein        = node_top,
	clust_scarcity = 24*24*24,
	clust_num_ores = 9,
	clust_size     = 3,
	biomes         = {"great_barrier_reef"},
	y_min     = -10,
	y_max     = -5,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_staghorn_blue",
	wherein        = node_top,
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	biomes         = {"great_barrier_reef"},
	y_min     = -6,
	y_max     = -2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_staghorn_pink",
	wherein        = node_top,
	clust_scarcity = 9*9*9,
	clust_num_ores = 25,
	clust_size     = 5,
	biomes         = {"great_barrier_reef"},
	y_min     = -6,
	y_max     = -2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_staghorn_purple",
	wherein        = node_top,
	clust_scarcity = 13*13*13,
	clust_num_ores = 20,
	clust_size     = 4,
	biomes         = {"great_barrier_reef"},
	y_min     = -6,
	y_max     = -2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_staghorn_yellow",
	wherein        = node_top,
	clust_scarcity = 12*12*12,
	clust_num_ores = 22,
	clust_size     = 4,
	biomes         = {"great_barrier_reef"},
	y_min     = -6,
	y_max     = -2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:coral_stone_tube_sponge",
	wherein        = node_top,
	clust_scarcity = 21*21*21,
	clust_num_ores = 10,
	clust_size     = 2,
	biomes         = {"great_barrier_reef"},
	y_min     = -15,
	y_max     = -3,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:woodship",
	wherein        = node_top,
	clust_scarcity = 30*30*30,
	clust_num_ores = 1,
	clust_size     = 12,
	biomes         = {"great_barrier_reef"},
	y_min     = -64,
	y_max     = -6,
})



--
-- Decorations
--

	-- Narrowleaf Seagrass
minetest.register_decoration({
	deco_type = "simple",
	place_on = node_top,
	sidelen = 80,
	fill_ratio = 0.005,
	biomes = {"great_barrier_reef"},
	y_min     = -10,
	y_max     = -2,
	decoration = "australia:sea_grass",
	flags = "force_placement",
})
