-- Non-uniform leaf decay functions for Australia -> NULDA
-- Originally based on code from minetest_game/default/functions.lua
-- (C) celeron55 (Perttu Ahola) and others, licensed under the GNU Lesser General
-- Public License, version 2.1
-- but extended to support three radii due to the broad or tall nature of some
-- trees in Australia mod

local function nulda_after_destruct(pos, oldnode, radii, leaves)
	local pos_min = vector.subtract(pos, radii)
	local pos_max = vector.add(pos, radii)
	for _, v in pairs(minetest.find_nodes_in_area(pos_min, pos_max, leaves)) do
		local node = minetest.get_node(v)
		local timer = minetest.get_node_timer(v)
		if node.param2 ~= 1 and not timer:is_started() then
			timer:start(math.random(20, 120) / 10)
		end
	end
end

local movement_gravity = tonumber(
	minetest.settings:get("movement_gravity")) or 9.81

local function nulda_on_timer(pos, radii, trunks, leaves)
	local pos_min = vector.subtract(pos, radii)
	local pos_max = vector.add(pos, radii)
	for _, v in pairs(minetest.find_nodes_in_area(pos_min, pos_max, trunks)) do
		return false
	end

	local node = minetest.get_node(pos)
	local drops = minetest.get_node_drops(node.name)
	for _, item in ipairs(drops) do
		local is_leaf
		for _, v in pairs(leaves) do
			if v == item then
				is_leaf = true
			end
		end
		if minetest.get_item_group(item, "leafdecay_drop") ~= 0 or
				not is_leaf then
			minetest.add_item({
				x = pos.x - 0.5 + math.random(),
				y = pos.y - 0.5 + math.random(),
				z = pos.z - 0.5 + math.random(),
			}, item)
		end
	end

	minetest.remove_node(pos)
	minetest.check_for_falling(pos)

	-- spawn a few particles for the removed node
	minetest.add_particlespawner({
		amount = 8,
		time = 0.001,
		minpos = vector.subtract(pos, {x=0.5, y=0.5, z=0.5}),
		maxpos = vector.add(pos, {x=0.5, y=0.5, z=0.5}),
		minvel = vector.new(-0.5, -1, -0.5),
		maxvel = vector.new(0.5, 0, 0.5),
		minacc = vector.new(0, -movement_gravity, 0),
		maxacc = vector.new(0, -movement_gravity, 0),
		minsize = 0,
		maxsize = 0,
		node = node,
	})
end

function aus.register_nonuniform_leafdecay(def)
	assert(def.leaves)
	assert(def.trunks)
	assert(def.radii)
	for _, v in pairs(def.trunks) do
		minetest.override_item(v, {
			after_destruct = function(pos, oldnode)
				nulda_after_destruct(pos, oldnode, def.radii, def.leaves)
			end,
		})
	end
	for _, v in pairs(def.leaves) do
		minetest.override_item(v, {
			on_timer = function(pos)
				nulda_on_timer(pos, def.radii, def.trunks, def.leaves)
			end,
		})
	end
end
