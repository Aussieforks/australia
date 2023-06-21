-- mods/australia/crafting.lua

--
-- Ordinary recipes
--

-- Moss
minetest.register_craft({
	output = 'australia:moss',
	type = 'shapeless',
	recipe = {'australia:moss_with_fungus'},
	replacements = {{'australia:moss_with_fungus', 'flowers:mushroom_brown'}},
})

minetest.register_craft({
	output = 'australia:moss_with_fungus',
	type = 'shapeless',
	recipe = {'australia:moss', 'flowers:mushroom_brown'},
})


-- Bricks
minetest.register_craft({
	output = 'australia:red_stonebrick 4',
	recipe = {
		{'australia:red_stone', 'australia:red_stone'},
		{'australia:red_stone', 'australia:red_stone'},
	}
})

minetest.register_craft({
	output = 'australia:bluestone_brick 4',
	recipe = {
		{'australia:bluestone', 'australia:bluestone'},
		{'australia:bluestone', 'australia:bluestone'},
	}
})

-- Fences
for i in ipairs(aus.treelist) do
	local treename			= aus.treelist[i][1]
	minetest.register_craft({
		output = "australia:fence_"..treename.."_wood 4",
		recipe = {
			{"australia:"..treename.."_wood", "group:stick", "australia:"..treename.."_wood"},
			{"australia:"..treename.."_wood", "group:stick", "australia:"..treename.."_wood"},
		}
	})
end

-- Ferns
minetest.register_craft({
	type = "shapeless",
	output = "australia:fiddlehead 3",
	recipe = {"australia:fern_01"},
	replacements = {
		{"australia:fern_01", "australia:ferntuber"}
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "australia:fiddlehead 3",
	recipe = {"australia:tree_fern_leaves"},
	replacements = {
		{"australia:tree_fern_leaves", "australia:sapling_tree_fern"}
	},
})

-- Wood planks
for i in ipairs(aus.treelist) do
	local treename			= aus.treelist[i][1]
	minetest.register_craft({
		output = "australia:"..treename.."_wood 4",
		recipe = {
			{"australia:"..treename.."_tree"}
		}
	})
end



--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "australia:bluestone",
	recipe = "australia:bluestone_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "australia:red_stone",
	recipe = "australia:red_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "australia:ferntuber_roasted",
	recipe = "australia:ferntuber",
	cooktime = 3,
})

minetest.register_craft({
	type = "cooking",
	output = "australia:fiddlehead_roasted",
	recipe = "australia:fiddlehead",
	cooktime = 1,
})

