


--
-- Ferns
--

	-- Fern
minetest.register_node("australia:fern", {
	description = "Hypolepis rugosula: Ruddy Ground Fern",
	inventory_image = "aus_fern.png",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"aus_fern_mid.png"},
	walkable = false,
	buildable_to = true,
    -- @@@ Josselin2
--	groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
	drop = "australia:fern",
})

	-- Small Fern
minetest.register_node("australia:small_fern", {
	description = "Pellaea falcata: Sickle Fern",
	inventory_image = "aus_fern.png",
	drawtype = "plantlike",
	visual_scale = 1,
	paramtype = "light",
	tiles = {"aus_fern.png"},
	walkable = false,
	buildable_to = true,
    -- @@@ Josselin2
--	groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
	drop = "australia:small_fern",
})

	-- Tree fern leaves
minetest.register_node("australia:tree_fern_leaves", {
	description = "Dicksonia Antarctica: Tree Fern Crown",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"aus_fern_tree.png"},
	inventory_image = "aus_fern_tree_inv.png",
	walkable = false,
	groups = {snappy=3,flammable=2,attached_node=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"autralia:sapling_tree_fern"},
				rarity = 20,
			},
			{
				items = {"australia:tree_fern_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})
minetest.register_node("australia:tree_fern_leaves_02", {
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"aus_fern_big.png"},
	walkable = false,
	groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"australia:sapling_tree_fern"},
				rarity = 20,
			},
			{
				items = {"australia:tree_fern_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})

	-- Fern trunk
minetest.register_node("australia:fern_trunk", {
	description = "Dicksonia Antarctica: Tree Fern Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"aus_fern_trunk_top.png",
		"aus_fern_trunk_top.png",
		"aus_fern_trunk.png"
	},
	node_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "australia:fern_trunk" then 
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z}) 
            minetest.add_item(pos,"australia:fern_trunk")
        end
    end,
    -- @@@ Josselin2
    use_texture_alpha = "clip",
})

	-- Giant tree fern leaves
minetest.register_node("australia:tree_fern_leaves_giant", {
	description = "Dicksonia Antarctica: Tree Fern Crown",
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	wield_scale = {x=0.175, y=0.175, z=0.175},
	paramtype = "light",
	tiles = {"aus_fern_tree_giant.png"},
	inventory_image = "aus_fern_tree.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		not_in_creative_inventory=1
	},
	drop = {
		max_items = 2,
		items = {
			{
				-- occasionally, drop a second sapling instead of leaves
				-- (extra saplings can also be obtained by replanting and
				--  reharvesting leaves)
				items = {"australia:sapling_giant_tree_fern"},
				rarity = 10,
			},
			{
				items = {"australia:sapling_giant_tree_fern"},
			},
			{
				items = {"australia:tree_fern_leaves_giant"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})

	-- Giant tree fern leaf part
minetest.register_node("australia:tree_fern_leaf_big", {
	description = "Dicksonia Antarctica: Giant Tree Fern Leaves",
	drawtype = "raillike",
	paramtype = "light",
	tiles = {
		"aus_tree_fern_leaf_big.png",
	},
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		not_in_creative_inventory=1
	},
	drop = "",
	sounds = default.node_sound_leaves_defaults(),
})

	-- Giant tree fern leaf end
minetest.register_node("australia:tree_fern_leaf_big_end", {
	description = "Dicksonia Antarctica: Giant Tree Fern Leaf End",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = { "aus_tree_fern_leaf_big_end.png" },
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2,   1/2, 1/2,   33/64, 1/2},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2,   1/2, 1/2,   33/64, 1/2},
	},
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		not_in_creative_inventory=1
	},
	drop = "",
	sounds = default.node_sound_leaves_defaults(),
    -- @@@ Josselin2
    use_texture_alpha = "clip",
})

	-- Giant tree fern trunk top
minetest.register_node("australia:fern_trunk_big_top", {
	description = "Dicksonia Antarctica: Giant Tree Fern Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"aus_fern_trunk_big_top.png^aus_tree_fern_leaf_big_cross.png",
		"aus_fern_trunk_big_top.png^aus_tree_fern_leaf_big_cross.png",
		"aus_fern_trunk_big.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2,  33/64, -1/2, 1/2, 33/64, 1/2},
			{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
	},
	groups = {
		tree=1,
		choppy=2,
		oddly_breakable_by_hand=2,
		flammable=3,
		wood=1,
		not_in_creative_inventory=1,
		leafdecay=3 -- to support vines
	},
	drop = "australia:fern_trunk_big",
	sounds = default.node_sound_wood_defaults(),
    -- @@@ Josselin2
    use_texture_alpha = "clip",    
})

	-- Giant tree fern trunk
minetest.register_node("australia:fern_trunk_big", {
	description = "Dicksonia Antarctica: Giant Tree Fern Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"aus_fern_trunk_big_top.png",
		"aus_fern_trunk_big_top.png",
		"aus_fern_trunk_big.png"
	},
	node_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
	},
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "australia:fern_trunk_big" or node.name == "australia:fern_trunk_big_top" then 
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z}) 
            minetest.add_item(pos,"australia:fern_trunk_big")
        end
    end,
    -- @@@ Josselin2
    use_texture_alpha = "clip",
})

	-- Tree fern sapling
minetest.register_node("australia:sapling_tree_fern", {
	description = "Dicksonia Antarctica: Tree Fern Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"aus_sapling_tree_fern.png"},
	inventory_image = "aus_sapling_tree_fern.png",
	walkable = false,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})

	-- Giant tree fern sapling
minetest.register_node("australia:sapling_giant_tree_fern", {
	description = "Dicksonia Antarctica: Giant Tree Fern Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"aus_sapling_tree_fern_giant.png"},
	inventory_image = "aus_sapling_tree_fern_giant.png",
	walkable = false,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})
