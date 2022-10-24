-- mods/australia/schematics_commands.lua
-- Functions for placing tree schematics and testing leaf decay
-- Restricted to server priv. Use with caution! Typos can lead to a server
-- crash. This is debugging code primarily.

minetest.register_chatcommand("aus_schems_report", {
	params = "tree_gallery",
	description = "Report statistics for all australia schematics",
	privs = {server=true},
	func = function(name, param)
		local schems_keys = {}
		local x_total = 0
		local x_max = 0
		local z_total = 0
		local z_max = 0
		local schems_total = 0
		for schem_family, schems in pairs(aus.schematics) do
			for schem_idx, schem in pairs(schems) do
				x_total = x_total + schem.size.x
				z_total = z_total + schem.size.z
				x_max = math.max(x_max, schem.size.x)
				z_max = math.max(z_max, schem.size.z)
				schems_total = schems_total + 1
			end
		end

		local x_avg = x_total / schems_total
		local z_avg = z_total / schems_total

		print(string.format("x: total = %d, avg = %f", x_total, x_avg))
		print(string.format("z: total = %d, avg = %f", z_total, z_avg))
		print(string.format("Total schematics: %d", schems_total))

	end
})

local function do_leafdecay_between(pos_min, pos_max)
	local x_min = pos_min.x
	local y_min = pos_min.y
	local z_min = pos_min.z

	local x_max = pos_max.x
	local y_max = pos_max.y
	local z_max = pos_max.z

	for x = x_min, x_max do
		for y = y_min, y_max do
			for z = z_min, z_max do
				local pos = vector.new(x,y,z)
				local node = minetest.get_node_or_nil(pos)
				if not node then
					error(string.format("Node not loaded: %s", pos))
				end

				if node.name:match("tree") then
					local result = minetest.set_node(pos, {name="air"})
				end
			end
		end
	end
end

local function leafdecay_on_emerge(blockpos, action, calls_remaining, param)

	if action == minetest.EMERGE_CANCELLED or minetest.emerge_ERRORED then
		error(string.format("Emerge errored/cancelled: %s", blockpos))
	end

	do_leafdecay_between(
		vector.new(blockpos.x * 16, blockpos.y * 16, blockpos.z * 16),
		vector.new(blockpos.x * 16 + 15, blockpos.y * 16 + 15, blockpos.z * 16 + 15)
	)
end

minetest.register_chatcommand("aus_tree_gallery", {
	params = "tree_gallery [leafdecay]",
	description = "Place all Australia tree schematics, optionally simulating leaf decay by punching out all the leaves (lag warning)",
	privs = {server=true},
	func = function(name, param)

		local do_leafdecay = param == "leafdecay"

		local schems_keys = {}
		local x_total = 0
		local x_max = 0
		local z_total = 0
		local z_max = 0
		local schems_total = 0
		for schem_family, schems in pairs(aus.schematics) do
			table.insert(schems_keys, schem_family)
			for schem_idx, schem in pairs(schems) do
				x_total = x_total + schem.size.x
				z_total = z_total + schem.size.z
				x_max = math.max(x_max, schem.size.x)
				z_max = math.max(z_max, schem.size.z)
				schems_total = schems_total + 1
			end
		end
		table.sort(schems_keys)

		local x_avg = x_total / schems_total
		local z_avg = z_total / schems_total

		local row_quota = math.ceil(math.sqrt(schems_total))

		print(string.format("x: total = %d, avg = %f, sqrt=%f", x_total, x_avg, math.sqrt(x_total)))
		print(string.format("z: total = %d, avg = %f, sqrt=%f", z_total, z_avg, math.sqrt(z_total)))
		print(string.format("Total schematics: %d", schems_total))
		print(string.format("Row quota: %d", row_quota))


		local x_delta_max = 1.1*(x_total/math.ceil(z_avg))
		local pos = minetest.get_player_by_name(name):get_pos()

		local x_orig = pos.x
		local pos_orig = vector.new(pos.x, pos.y, pos.z)

		local x_max = 0
		local z_max = 0
		local y_max = 0
		local z_max_row = 0
		local placed_this_row = 0
		for i in ipairs(schems_keys) do
			local schemfamily_name = schems_keys[i]
			local schemfamily = aus.schematics[schemfamily_name]

			local plus_this_family = placed_this_row
			for schemidx, schem in pairs(schemfamily) do
				plus_this_family = plus_this_family + 1
			end
			local x_delta = pos.x - x_orig
			--[[print(string.format("schemfamily_name = %s, x_delta = %d, plus_this_family = %d",
				   schemfamily_name, x_delta, plus_this_family))--]]
			if (plus_this_family >= row_quota) or (x_delta > x_delta_max) then
				pos.x = x_orig
				pos.z = pos.z + z_max_row
				z_max_row = 0
				placed_this_row = 0
			end

			for schemidx, schem in pairs(schemfamily) do
				minetest.place_schematic(pos, schem, "0")
				pos.x = pos.x + schem.size.x + 1

				z_max_row = math.max(schem.size.z, z_max_row)

				x_max = math.max(x_max, pos.x + schem.size.x)
				y_max = math.max(y_max, schem.size.y)
				z_max = math.max(z_max, pos.z + schem.size.z)

				placed_this_row = placed_this_row + 1
			end
		end

		if not do_leafdecay then return end

		local pos_max = vector.new(x_max, y_max, z_max)
		minetest.emerge_area(pos_orig, pos_max, leafdecay_on_emerge)
	end
})

minetest.register_chatcommand("aus_schem_here", {
	params = "schem_here <name> [idx] [leafdecay]",
	description = "Place a specific schematic or schematic at your position, and optionally test leaf decay by digging all the tree trunks.",
	privs = {server=true},
	func = function(name, param)

		local params = param:split(" ")
		local schemname = params[1]
		local schem_idx = tonumber(params[2])
		local do_leafdecay

		local x_max = 0
		local y_max = 0
		local z_max = 0

		local pos = minetest.get_player_by_name(name):get_pos()
		local pos_orig = vector.new(pos.x, pos.y, pos.z)

		if not schem_idx then
			for schemnr, schem in pairs(aus.schematics[schemname]) do
				minetest.place_schematic(pos, schem, "0")
				pos.x = pos.x + schem.size.x
				x_max = math.max(x_max, pos.x)
				y_max = math.max(y_max, pos.y + schem.size.y)
				print(string.format("size.y = %s, y_max=%s", schem.size.y, y_max))
				z_max = math.max(z_max, pos.z + schem.size.z)
				print(string.format("size.z = %s, z_max=%s", schem.size.z, z_max))
			end
		else
			local schem = aus.schematics[schemname][schem_idx]
			minetest.place_schematic(pos, schem, "0")
			x_max = pos.x + schem.size.x
			y_max = pos.y + schem.size.y
			z_max = pos.z + schem.size.z
		end

		if schem_idx then
			do_leafdecay = params[3] == "leafdecay"
		else
			do_leafdecay = params[2] == "leafdecay"
		end

		if not do_leafdecay then return end
		print(pos_orig, vector.new(x_max, y_max, z_max))
		do_leafdecay_between(pos_orig, vector.new(x_max, y_max, z_max))
	end
})
