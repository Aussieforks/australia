---
--- Loot: woodships and submarines
---
--
local function place_woodship(pos)
	local yp = {x = pos.x, y = pos.y + 3, z = pos.z}
	if not
		minetest.get_node(pos).name == "australia:woodship" and
		(minetest.get_node(yp).name == "default:water_source" or
		minetest.get_node(yp).name == "australia:water_source")
	then return end

	minetest.add_node(pos, {name = "default:sand"})

	pos.y = pos.y + 1
	pos.x = pos.x - 6

	for a = 1, 11 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x - 10

	for a = 1, 9 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
	end

	pos.z = pos.z - 2
	pos.x = pos.x - 9

	for a = 1, 9 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
	end


	pos.y = pos.y + 1
	pos.x = pos.x - 8
	pos.z = pos.z - 1

	for a = 1, 7 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
	end

	pos.z = pos.z + 4
	pos.x = pos.x - 7

	for a = 1, 7 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
	end

	pos.z = pos.z - 1
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:wood"})

	pos.z = pos.z - 1
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:wood"})

	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:tree"})

	pos.z = pos.z - 1
	pos.x = pos.x - 2
	minetest.add_node(pos, {name = "default:tree"})

	pos.z = pos.z + 2
	pos.x = pos.x - 8
	minetest.add_node(pos, {name = "default:tree"})

	pos.z = pos.z - 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:tree"})

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:tree"})

	pos.z = pos.z - 1
	pos.x = pos.x + 2
	minetest.add_node(pos, {name = "default:tree"})


	pos.y = pos.y + 1
	pos.z = pos.z - 1

	for a = 1, 7 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:wood"})
	end

	pos.z = pos.z + 4
	pos.x = pos.x - 7

	for a = 1, 7 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:wood"})
	end

	pos.z = pos.z - 1
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:wood"})

	pos.z = pos.z - 1
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:wood"})

	pos.z = pos.z - 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:wood"})

	pos.z = pos.z + 2
	pos.x = pos.x - 8
	minetest.add_node(pos, {name = "default:wood"})

	pos.z = pos.z - 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:wood"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:wood"})
	end

	pos.z = pos.z - 1
	pos.x = pos.x + 4
	minetest.add_node(pos, {name = "default:wood"})

	pos.z = pos.z + 1
	pos.x = pos.x + 3
	minetest.add_node(pos, {name = "default:wood"})

	pos.y = pos.y + 1
	minetest.add_node(pos, {name = "default:wood"})

	pos.y = pos.y - 2
	minetest.add_node(pos, {name = "default:wood"})

	pos.y = pos.y + 3
	pos.z = pos.z - 4

	for a = 1, 7 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:wood"})
	end

	pos.z = pos.z - 3

	for a = 1, 2 do
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "default:wood"})
	end

	pos.y = pos.y + 1
	pos.z = pos.z - 3

	for a = 1, 5 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:wood"})
	end

	pos.y = pos.y + 1
	pos.z = pos.z - 2
	minetest.add_node(pos, {name = "default:wood"})

	pos.y = pos.y - 7
	pos.z = pos.z + 1
	pos.x = pos.x - 2
	minetest.add_node(pos, {name = "australia:woodshipchest"})
end

minetest.register_node("australia:woodship", {
	description = "Woodship spawner",
	tiles = {"default_sand.png"},
	inventory_image = "aus_woodship_spawner.png",
	wield_image = "aus_woodship_spawner.png",
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1},
	sounds = default.node_sound_sand_defaults(),
	on_construct = function(pos)
		place_woodship(pos)
	end
})

local loot_noise = PerlinNoise({
	offset = 0,
	scale = 65536,
	spread = vector.new(1,1,1),
	seed = tonumber(minetest.get_mapgen_setting("seed")) * 1361 - 114,
	octaves = 1,
	persist = 1
})

local loot = {}
-- add default loot
for _,item in pairs({
	"default:coal_lump 5",
	"default:iron_lump 10",
	"default:gold_lump 7",
	"default:gold_lump 4",
	"default:diamond 3",
}) do
	loot[#loot+1] = item
end

-- add group:seed loot
for name,def in pairs(minetest.registered_items) do
	if def.groups.seed then
		loot[#loot+1] = name
	end
end
local nloot = #loot

minetest.register_node("australia:woodshipchest", {
	description = "Wooden ship chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	drop = 'default:chest',
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local r = PcgRandom(loot_noise:get_3d(pos))

		local contents = {}
		for i=1,r:next(1,5) do
			table.insert(contents, loot[r:next(1,nloot)])
		end

		local node = minetest.get_node(pos)
		minetest.set_node(pos, {name="default:chest", param1=node.param1, param2=node.param2})

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local inv_size = inv:get_size("main")
		for idx, item in pairs(contents) do
			local slot = r:next(1, inv_size)
			if inv:get_stack("main", slot):is_empty() then
				inv:set_stack("main", slot, ItemStack(item))
			else
				inv:add_item("main", ItemStack(item))
			end
		end
	end,

})

minetest.register_lbm({
	nodenames = {"australia:woodship"},
	name = "australia:convert_placed_woodships",
	run_at_every_load = true,
	action = place_woodship
})

local function place_submarine(pos)
	minetest.add_node(pos, {name = "default:dirt"})

	pos.y = pos.y + 1
	pos.x = pos.x - 15

	for a = 1, 31 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x + 1

	for a = 1, 31 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x +1

	for a = 1, 27 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 3
	pos.x = pos.x + 1

	for a = 1, 27 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 1
	pos.x = pos.x + 2

	for a = 1, 21 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 5
	pos.x = pos.x + 1

	for a = 1, 21 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.y = pos.y + 1
	pos.z = pos.z + 1
	pos.x = pos.x - 1

	for a = 1, 21 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 7
	pos.x = pos.x + 1

	for a = 1, 21 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 24
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 5
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 22
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 29
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 3
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 28
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 32
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 32
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.y = pos.y + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x + 32
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z - 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x - 32
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z - 1
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x + 28
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z + 3
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x - 28
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z + 1
	pos.x = pos.x + 2
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x + 22
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z + 1
	pos.x = pos.x - 2
	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 9 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.z = pos.z - 6
	pos.x = pos.x - 3
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x + 22
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z - 1
	pos.x = pos.x - 2

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 9 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y + 1
	pos.z = pos.z + 7
	pos.x = pos.x - 1
	for a = 1, 21 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 7
	pos.x = pos.x + 1

	for a = 1, 21 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 24
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 5
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 22
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 29
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 3
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 28
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 32
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 32
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.y = pos.y + 1
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 28
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 28
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 1
	pos.x = pos.x + 2
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 22
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 3
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 22
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	pos.x = pos.x + 2
	for a = 1, 21 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 5
	pos.x = pos.x + 1
	for a = 1, 21 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.y = pos.y + 1
	pos.z = pos.z + 2
	pos.x = pos.x - 4
	for a = 1, 3 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.x = pos.x + 21
	for a = 1, 3 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x + 1
	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.x = pos.x - 21
	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 2
	pos.x = pos.x + 3
	for a = 1, 4 do
		pos.z = pos.z - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 1
	pos.x = pos.x + 1
	for a = 1, 4 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.x = pos.x + 6
	for a = 1, 13 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 3
	pos.x = pos.x + 1
	for a = 1, 13 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	for a = 1, 13 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:bronzeblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x + 1
	for a = 1, 13 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:bronzeblock"})
	end

	pos.z = pos.z - 3
	for a = 1, 6 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.z = pos.z + 5
	pos.x = pos.x - 1
	for a = 1, 6 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y + 1
	for a = 1, 4 do
		pos.z = pos.z - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 5
	pos.z = pos.z - 1
	for a = 1, 4 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	for a = 1, 4 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x + 1
	pos.z = pos.z - 3
	for a = 1, 4 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y + 1
	pos.x = pos.x - 1
	pos.z = pos.z - 1
	for a = 1, 4 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x + 5
	pos.z = pos.z + 1
	for a = 1, 4 do
		pos.z = pos.z - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	for a = 1, 4 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	pos.z = pos.z + 3
	for a = 1, 4 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y + 1
	pos.x = pos.x - 1
	pos.z = pos.z - 1
	for a = 1, 2 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	pos.z = pos.z - 1
	for a = 1, 2 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y - 7
	pos.x = pos.x +16
	pos.z = pos.z +3
	minetest.add_node(pos, {name = "australia:submarinechest"})
end

minetest.register_node("australia:submarine", {
	description = "Submarine spawner",
	tiles = {"default_dirt.png"},
	inventory_image = "aus_submarine_spawner.png",
	wield_image = "aus_submarine_spawner.png",
	is_ground_content = true,
	groups = {crumbly=3, soil=1},
	sounds = default.node_sound_dirt_defaults(),
	on_construct = function(pos)
		minetest.chat_send_all("U-Boat spawn point! :" .. minetest.pos_to_string(pos, 0))
		place_submarine(pos)
	end
})

local have_technic_worldgen = minetest.get_modpath('technic_worldgen')

minetest.register_node("australia:submarinechest", {
	description = "U-boat chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	paramtype2 = "facedir",
	drop = 'default:chest',
	is_ground_content = false,
	on_construct = function(pos)
		minetest.chat_send_all("U-Boat chest! :" .. minetest.pos_to_string(pos, 1))
		local r = PcgRandom(loot_noise:get_3d(pos))

		local contents = {}
		table.insert(contents, "default:sword_steel 2")
		if have_technic_worldgen and r:next(1,2) == 1 then
			table.insert(contents, "technic:mineral_uranium 18")
		else
			table.insert(contents, "tnt:tnt 3")
		end

		local node = minetest.get_node(pos)
		minetest.set_node(pos, {name="default:chest", param1=node.param1, param2=node.param2})

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local inv_size = inv:get_size("main")
		for idx, item in pairs(contents) do
			local slot = r:next(1, inv_size)
			if inv:get_stack("main", slot):is_empty() then
				inv:set_stack("main", slot, ItemStack(item))
			else
				inv:add_item("main", ItemStack(item))
			end
		end
	end,
})

minetest.register_lbm({
	nodenames = {"australia:submarine"},
	name = "australia:convert_placed_submarines",
	action = function(pos, node)
		local yp = {x = pos.x, y = pos.y + 8, z = pos.z}
		if node.name == "australia:submarine"
		and (
			minetest.get_node(yp).name == "default:water_source"
			or minetest.get_node(yp).name == "australia:water_source"
		) then
			place_submarine(pos)
		end
	end
})
