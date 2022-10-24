--
-- Trees
--

aus.treelist = {
	--treename, treedesc, treetrunk_dia, treesapling, treefruit, treefruit_desc, treefruit_scale, treefruit_health, leafdecay_radius
	{"black_box", "Eucalyptus largiflorens: Black Box", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"black_wattle", "Acacia melanoxylon: Black Wattle", 0.75, "acacia", nil, nil, nil, nil, 3},
	{"blue_gum", "Eucalyptus globulus: Blue Gum", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"boab", "Adansonia gregorii: Boab", 1.0, "boab", nil, nil, nil, nil, 3},
	{"bull_banksia", "Banksia grandis: Bull Banksia", 0.33, "banksia", nil, nil, nil, nil, 3},
	{"celery_top_pine", "Phyllocladus aspleniifolius: Celery-top Pine", 1, "pine", nil, nil, nil, nil, vector.new(3,4,3)},
	{"cherry", "Exocarpos cupressiformis: Australian Cherry", 0.5, "berry", "cherry", "Australian Cherries", 0.67, 1, 3},
	{"cloncurry_box", "Eucalyptus leucophylla: Cloncurry Box", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"coast_banksia", "Banksia integrifolia: Coast Banksia", 1.0, "banksia", nil, nil, nil, nil, 3},
	{"coolabah", "Eucalyptus coolabah: Coolabah", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"daintree_stringybark", "Eucalyptus pellita: Daintree Stringybark", 1.0, "eucalyptus", nil, nil, nil, nil, 2},
	{"darwin_woollybutt", "Eucalyptus miniata: Darwin Woollybutt", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"desert_oak", "Allocasuarina decaisneana: Desert Oak", 1.0, "acacia", nil, nil, nil, nil, 3},
	{"fan_palm", "Licuala ramsayi: Australian Fan Palm", 1.0, "palm", nil, nil, nil, nil, vector.new(3,2,3)},
	{"golden_wattle", "Acacia pycnantha: Golden Wattle", 0.33, "acacia", nil, nil, nil, nil, 3},
	{"grey_mangrove", "Avicennia marina: Grey Mangrove", 0.25, "mangrove", nil, nil, nil, nil, 2},
	{"huon_pine", "Lagarostrobos franklinii: Huon Pine", 1.0, "pine", nil, nil, nil, nil, 3},
	{"illawarra_flame", "Brachychiton acerifolius: Illawarra Flame", 1.0, "illawarra_flame", nil, nil, nil, nil, 3},
	{"jarrah", "Eucalyptus marginata: Jarrah", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"karri", "Eucalyptus diversicolor: Karri", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"lemon_eucalyptus", "Eucalyptus citriodora: Lemon Eucalyptus", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"lemon_myrtle", "Backhousia citriodora: Lemon Myrtle", 0.5, "myrtle", nil, nil, nil, nil, 3},
	{"lilly_pilly", "Syzygium smithii: Lilly Pilly", 0.33, "berry", "lilly_pilly_berries", "Lilly Pilly Berries", 0.67, 1, 3},
	{"macadamia", "Macadamia tetraphylla: Prickly Macadamia", 0.75, "macadamia", "macadamia", "Macadamia Nuts", 0.67, 1, 3},
	{"mangrove_apple", "Sonneratia caseolaris: Mangrove Apple", 0.75, "mangrove_apple", "mangrove_apple", "Mangrove Apple", 0.67, 1, 3},
	{"marri", "Corymbia calophylla: Marri", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"merbau", "Intsia bijuga: Merbau", 1.0, "merbau", nil, nil, nil, nil, vector.new(8,3,8)},
	{"moreton_bay_fig", "Ficus macrophylla: Moreton Bay Fig", 1.0, "fig", "moreton_bay_fig", "Moreton Bay Fig", 0.67, 1, 3},
	{"mulga", "Acacia aneura: Mulga", 0.5, "acacia", nil, nil, nil, nil, 3},
	{"paperbark", "Melaleuca quinquenervia: Paper Bark", 1.0, "melaleuca", nil, nil, nil, nil, 3},
	{"quandong", "Santalum acuminatum: Desert Quandong", 0.25, "quandong", "quandong", "Desert Quandong", 0.5, 1, 3},
	{"red_bottlebrush", "Melaleuca citrina: Red Bottlebrush", 0.33, "melaleuca", nil, nil, nil, nil, 3},
	{"river_oak", "Casuarina cunninghamiana: River Oak", 1.0, "acacia", nil, nil, nil, nil, vector.new(3,4,3)},
	{"river_red_gum", "Eucalyptus camaldulensis: River Red Gum", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"rottnest_island_pine", "Callitris preissii: Rottnest Island Pine", 0.75, "pine", nil, nil, nil, nil, vector.new(3,4,3)},
	{"scribbly_gum", "Eucalyptus haemastoma: Scribbly Gum", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"shoestring_acacia", "Acacia stenophylla: Shoestring Acacia", 1.0, "acacia", nil, nil, nil, nil, 3},
	{"snow_gum", "Eucalyptus pauciflora: Snow Gum", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"southern_sassafras", "Atherosperma moschatum: Southern Sassafras", 1, "pine", nil, nil, nil, nil, vector.new(4,6,4)},
	{"stilted_mangrove", "Rhizophora stylosa: Stilted Mangrove", 0.25, "mangrove", nil, nil, nil, nil, 2},
	{"sugar_gum", "Eucalyptus cladocalyx: Sugar Gum", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"swamp_bloodwood", "Corymbia ptychocarpa: Swamp Bloodwood", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"swamp_gum", "Eucalyptus regnans: Swamp Gum", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"swamp_paperbark", "Melaleuca rhaphiophylla: Swamp Paperbark", 0.5, "melaleuca", nil, nil, nil, nil, 3},
	{"tasmanian_myrtle", "Lophozonia cunninghamii: Tasmanian Myrtle", 1.0, "myrtle", nil, nil, nil, nil, 3},
	{"tea_tree", "Melaleuca alternifolia: Tea", 0.5, "melaleuca", nil, nil, nil, nil, 2},
	{"white_box", "Eucalyptus albens: White Box", 1.0, "eucalyptus", nil, nil, nil, nil, 3},
	{"wirewood", "Acacia coriacea: Wirewood", 0.33, "acacia", nil, nil, nil, nil, 3},
}

for _, treedef in ipairs(aus.treelist) do
	local treename			= treedef[1]
	local treedesc			= treedef[2]
	local treetrunk_dia		= treedef[3]
	local treesapling		= treedef[4]
	local treefruit			= treedef[5]
	local treefruit_desc	= treedef[6]
	local treefruit_scale	= treedef[7]
	local treefruit_health	= treedef[8]
	local leafdecay_radius  = treedef[9]

	-- tree
	local node_d = {
		description = treedesc.. " Tree",
		tiles = {
			"aus_"..treename.."_treetop.png",
			"aus_"..treename.."_treetop.png",
			"aus_"..treename.."_tree.png"
		},
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
		sounds = default.node_sound_wood_defaults(),
		on_place = minetest.rotate_node,
	}
	-- Some trunks aren't a metre wide.
	if treetrunk_dia and treetrunk_dia ~= 1 then
		local radius = treetrunk_dia / 2
		node_d.paramtype = "light"
		node_d.drawtype = "nodebox"
		node_d.node_box = { type = "fixed",
			fixed = { {-radius, -0.5, -radius, radius, 0.5, radius}, }
		}
		node_d.selection_box = { type = "fixed",
			fixed = { {-radius, -0.5, -radius, radius, 0.5, radius}, }
		}
	end
	local trunk_node_name = "australia:"..treename.."_tree"
	minetest.register_node(trunk_node_name, node_d)

	-- wood
	minetest.register_node("australia:"..treename.."_wood", {
		description = treedesc.." Wood Planks",
		tiles = {"aus_"..treename.."_wood.png"},
		groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
		sounds = default.node_sound_wood_defaults(),
	})


	local tree_leaf_name = "australia:"..treename.."_leaves"
	-- leaves
	minetest.register_node(tree_leaf_name, {
		description = treedesc.." Leaves",
		drawtype = "allfaces_optional",
		visual_scale = 1.3,
		tiles = { "aus_"..treename.."_leaves.png"},
		paramtype = "light",
		is_ground_content = false,
		groups = {snappy=3,flammable=2,leaves=1},
		drop = {
			max_items = 1,
			items = {
				{items = {"australia:"..treename.."_sapling"}, rarity = 50 },
				{items = {"australia:"..treename.."_leaves"} }
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})

	-- sapling
	minetest.register_node("australia:"..treename.."_sapling", {
		description = treedesc.." Sapling",
		drawtype = "plantlike",
		visual_scale = 1.0,
		tiles = {"aus_"..treesapling.."_sapling.png"},
		inventory_image = "aus_"..treesapling.."_sapling.png",
		wield_image = "aus_"..treesapling.."_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		is_ground_content = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
		},
		groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
		sounds = default.node_sound_leaves_defaults(),
	})

	-- fruit, if applicable
	local treefruit_name
	if treefruit then
		treefruit_name = "australia:"..treefruit..""
		minetest.register_node(treefruit_name, {
			description = treefruit_desc,
			drawtype = "plantlike",
			visual_scale = treefruit_scale,
			tiles = { "aus_"..treefruit..".png" },
			inventory_image = "aus_"..treefruit..".png",
			wield_image = "aus_"..treefruit..".png",
			paramtype = "light",
			sunlight_propagates = true,
			walkable = false,
			is_ground_content = false,
			selection_box = {
				type = "fixed",
				fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
			},
			groups = {fleshy=3,dig_immediate=3,flammable=2,leafdecay=2,leafdecay_drop=1},
			-- Fruit makes you healthy.
			on_use = minetest.item_eat(treefruit_health),
			sounds = default.node_sound_leaves_defaults(),
			after_place_node = function(pos, placer, itemstack)
				if placer:is_player() then
					minetest.set_node(pos, {name="australia:"..treefruit.."", param2=1})
				end
			end,
		})
	end

	-- leaf decay
	if type(leafdecay_radius) == "number" then
		default.register_leafdecay({
			trunks = {trunk_node_name},
			leaves = {tree_leaf_name, treefruit_name},
			radius = leafdecay_radius,
		})
	elseif type(leafdecay_radius == "table") then
		aus.register_nonuniform_leafdecay({
			trunks = {trunk_node_name},
			leaves = {tree_leaf_name, treefruit_name},
			radii = leafdecay_radius,
		})
	end

	-- fence
	default.register_fence("australia:fence_"..treename.."_wood", {
		description = treedesc.." Fence",
		texture = "aus_"..treename.."_wood.png",
		material = "australia:"..treename.."_wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	})
end
