---
--- Loot: woodships and submarines
---
minetest.register_node("australia:woodship", {
	description = "Sand for the wooden ship",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("australia:submarine", {
	description = "Dirt for the submarine",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults(),
	on_construct = function(pos)
		minetest.chat_send_all("U-Boat spawn point! :" .. minetest.pos_to_string(pos, 0))
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
