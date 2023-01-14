--
-- Grow trees from saplings
--

-- list of all saplings
aus.saplings2schems = {
	["australia:black_box_sapling"] =
		aus.schematics.black_box_tree,
	["australia:black_wattle_sapling"] =
		aus.schematics.black_wattle_tree,
	["australia:blue_gum_sapling"] =
		aus.schematics.blue_gum_tree,
	["australia:boab_sapling"] =
		aus.schematics.boab_tree,
	["australia:bull_banksia_sapling"] =
		aus.schematics.bull_banksia_tree,
	["australia:celery_top_pine_sapling"] =
		aus.schematics.celery_top_pine_tree,
	["australia:cherry_sapling"] =
		aus.schematics.cherry_tree,
	["australia:cloncurry_box_sapling"] =
		aus.schematics.cloncurry_box_tree,
	["australia:coast_banksia_sapling"] =
		aus.schematics.coast_banksia_big_tree,
	["australia:coolabah_sapling"] =
		aus.schematics.coolabah_tree,
	["australia:daintree_stringybark_sapling"] =
		aus.schematics.daintree_stringybark_tree,
	["australia:darwin_woollybutt_sapling"] =
		aus.schematics.darwin_woollybutt_tree,
	["australia:desert_oak_sapling"] =
		aus.schematics.desert_oak_tree,
	["australia:fan_palm_sapling"] =
		aus.schematics.fan_palm_tree,
	["australia:golden_wattle_sapling"] =
		aus.schematics.golden_wattle_tree,
	["australia:grey_mangrove_sapling"] =
		aus.schematics.grey_mangrove_tree,
	["australia:huon_pine_sapling"] =
		aus.schematics.huon_pine_tree,
	["australia:illawarra_flame_sapling"] =
		aus.schematics.illawarra_flame_tree,
	["australia:jarrah_sapling"] =
		aus.schematics.jarrah_tree,
	["australia:karri_sapling"] =
		aus.schematics.karri_tree,
	["australia:lemon_eucalyptus_sapling"] =
		aus.schematics.lemon_eucalyptus_tree,
	["australia:lemon_myrtle_sapling"] =
		aus.schematics.lemon_myrtle_tree,
	["australia:lilly_pilly_sapling"] =
		aus.schematics.lilly_pilly_tree,
	["australia:macadamia_sapling"] =
		aus.schematics.macadamia_tree,
	["australia:mangrove_apple_sapling"] =
		aus.schematics.mangrove_apple_tree,
	["australia:marri_sapling"] =
		aus.schematics.marri_tree,
	["australia:merbau_sapling"] =
		aus.schematics.merbau_tree,
	["australia:moreton_bay_fig_sapling"] =
		aus.schematics.moreton_bay_fig_tree,
	["australia:mulga_sapling"] =
		aus.schematics.mulga_tree,
	["australia:paperbark_sapling"] =
		aus.schematics.paperbark_tree,
	["australia:quandong_sapling"] =
		aus.schematics.quandong_tree,
	["australia:red_bottlebrush_sapling"] =
		aus.schematics.red_bottlebrush_tree,
    -- @@@ Josselin2
--	["australia:river_oak_sapling"] =
--		aus.schematics.river_oak_tree,
	["australia:river_oak_sapling"] =
		aus.schematics.river_oak_big_tree,
	["australia:river_red_gum_sapling"] =
		aus.schematics.river_red_gum_tree,
	["australia:rottnest_island_pine_sapling"] =
		aus.schematics.rottnest_island_pine_tree,
	["australia:scribbly_gum_sapling"] =
		aus.schematics.scribbly_gum_tree,
	["australia:shoestring_acacia_sapling"] =
		aus.schematics.shoestring_acacia_tree,
	["australia:snow_gum_sapling"] =
		aus.schematics.snow_gum_tree,
	["australia:southern_sassafras_sapling"] =
		aus.schematics.southern_sassafras_tree,
	["australia:stilted_mangrove_sapling"] =
		aus.schematics.stilted_mangrove_tree,
	["australia:sugar_gum_sapling"] =
		aus.schematics.sugar_gum_tree,
	["australia:swamp_bloodwood_sapling"] =
		aus.schematics.swamp_bloodwood_tree,
	["australia:swamp_gum_sapling"] =
		aus.schematics.swamp_gum_tree,
	["australia:swamp_paperbark_sapling"] =
		aus.schematics.swamp_paperbark_tree,
	["australia:tasmanian_myrtle_sapling"] =
		aus.schematics.tasmanian_myrtle_tree,
	["australia:tea_tree_sapling"] =
		aus.schematics.tea_tree_tree,
	["australia:white_box_sapling"] =
		aus.schematics.white_box_tree,
	["australia:wirewood_sapling"] =
		aus.schematics.wirewood_tree,
}

function aus.grow_sapling(pos)
	if not default.can_grow(pos) then
		-- Try again 2 minutes later (we'll be more generous than default because
		-- some trees take ages)
		minetest.get_node_timer(pos):start(120)
		return
	end
	local node = minetest.get_node(pos)
	local schems = aus.saplings2schems[node.name]
	assert(schems ~= nil, string.format("No such sapling registered: %s @%s", node.name, pos))

	minetest.log("action", string.format("[Australia] %s sapling grows into a tree at %s",
		node.name, minetest.pos_to_string(pos)))
	local schem = schems[math.random(1,#schems)]
	local adj = {x = pos.x - math.floor(schem.size.x / 2),
							 y = pos.y - 1,
							 z = pos.z - math.floor(schem.size.z / 2)}

	minetest.place_schematic(adj, schem, 'random', nil, true)
end

function aus.sapling_growthrate(schems, species, fruit)
	local nschems = #schems
	local node_counts = {}
	for schem_idx, schem in pairs(schems) do
		for data_idx, data_point in pairs(schem.data) do
			local nodename = data_point.name
			node_counts[nodename] = (node_counts[nodename] or 0) + 1
		end
	end
	local treemass = 0
	for node, count in pairs(node_counts) do
		local avg_count = node_counts[node] / nschems
		node_counts[node] = avg_count
		if node:match("tree") then
			treemass = treemass + avg_count
		elseif node:match("leaves")
			or (fruit and node:match(fruit))
		then
			-- Leaves and fruit take less to grow than wood (but leaves
			-- sometimes simulate branches, so not a huge penalty to mass either)
			treemass = treemass + (1/3) * avg_count
		end
	end

	-- Slight bias in favour of smaller trees
	-- From lightest (golden wattle) to heaviest (river red gum) this means 10-57+-10% minute wait times
	local avg_time = 10*treemass^0.7 + 500
	return 0.9*avg_time, 1.1*avg_time
end
