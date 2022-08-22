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
aus.schematics.boab_tree = {}
local max_r = 4
local ht = 4
local fruit = nil
local limbs = false
local tree = "australia:boab_tree"
local leaves = "australia:boab_leaves"
for r = 3,max_r do
	local schem = aus.generate_giant_tree_schematic(3, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	table.insert(aus.schematics.boab_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = 9,
		y_max = 35,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"kimberley"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

-- Darwin Woollybutt
aus.register_schem_to_biome("darwin_woollybutt_tree", "kimberley", {
	place_on = {"australia:red_dirt"},
	y_min = 12,
	y_max = 35,
	fill_ratio = 15000,
})

	-- Swamp Bloodwood
aus.schematics.swamp_bloodwood_tree = {}
local max_r = 4
local ht = 6
local fruit = nil
local limbs = nil
local tree = "australia:swamp_bloodwood_tree"
local leaves = "australia:swamp_bloodwood_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(3, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	table.insert(aus.schematics.swamp_bloodwood_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = 7,
		y_max = 35,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"kimberley"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

