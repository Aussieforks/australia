-- aus/nodes/coral.lua
-- Corals and other nodes that grow from stony beds on the sea floor.

local coral_growth_targets = {}

-- Since light won't be sampled at a frequent interval we assume daytime growth
-- over time. Minimum interval: 60, (artificially shallow) max: 1600
-- (minimum light level of 1 needed to grow at all)
local function coral_photosynthesis_interval(pos)
	local day_ll = minetest.get_node_light(vector.new(pos.x, pos.y+1, pos.z), 0.5)
	if day_ll == nil then
		-- REPORT: Only triggered when LBMs don't run on first world run,
		-- whereby no corals spawn at first.
		minetest.log("warning", string.format(
			"[Australia] Nil light above %s when calculating coral photosynthesis"
			.."assuming 0",
			pos))
		day_ll = 0
	end
	local median_interval = 60*(minetest.LIGHT_MAX - day_ll + 3)
	return (1/3)*median_interval, (5/3)*median_interval
end

local function coral_start_timer(pos)
	local timer = minetest.get_node_timer(pos)
	local min_interval, max_interval = coral_photosynthesis_interval(pos)
	timer:start(math.random(min_interval, max_interval))
end

local function iswater(node)
	return node.name == "default:water_source"
		or node.name == "default:water_flowing"
end

--[[
@arg pos: The position of the stone.
@arg node: The node information table as provided in callbacks.
@arg gentime: Whether the coral is being grown at world generation time.
coral reefs can grow as low as 50m, but minetest's topography is
exagerrated. We therefore limit it to where light is available.
--]]
local function coral_grow(pos, node, gentime)
	local above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local above_node = minetest.get_node(above)

	if iswater (above_node) then
		local above_above_node =
			minetest.get_node(vector.new(above.x, above.y+1, above.z))
		-- Too shallow, coral would die after growth
		if not iswater(above_above_node) then
			coral_start_timer(pos)
			if gentime then
				minetest.set_node(pos, {name = "default:sand"})
			end
			return
		end

		if (minetest.get_node_light(above) >= 1 or gentime) then
			minetest.set_node(above, {name = coral_growth_targets[node.name]})
		else
			coral_start_timer(pos)
		end
	else
		if not above_node.name == coral_growth_targets[node.name] then
			minetest.set_node(pos, {name = "default:stone"})
		end
		coral_start_timer(pos)
	end
end

--[[
Register a coral species and its spawning stone. The stone must be registered
to appropriate biomes as an ore separately for it to appear in the world.
A ? after the property name means it is optional
CoralDef = {
	nodename = "australia:"..., -- the coral
	nodename_stone? = "australia:, -- defaults to a pattern based on nodename,
		as in e.g. hammer_coral or staghorn_coral_blue
	nodename_bleached? = "australia:"... -- defaults to a suffix based on
		nodename, but can be overriden for e.g. groups of colour varieties
	image = "*.png", -- the coral's inventory image. .JPEG is NOT supported
		without providing an explicit image_bleached. (use .jpg instead)
	image_bleached = "*.png" -- the image to use when the coral bleaches
	hard = true/false, -- soft or hard coral; effects groups and sounds
	drawtype?, -- the coral's drawtype (to support nodeboxes instead of plantlikes)
	nodebox?, -- for nodebox drawtype, the nodebox definition
}
--]]
function aus.register_coral(def)
	local nodename = def.nodename
	assert(nodename, "Coral needs nodename")

	local nodename_stone = def.nodename_stone
	if not nodename_stone then
		local nn_pre, nn_suff
		nn_pre, nn_suff = nodename:match(":([a-z_]*)_coral_([a-z_]*)")

		if (nn_pre and nn_suff) then
			nodename_stone = "australia:coral_stone_"..nn_pre.."_"..nn_suff
		else
			nn_pre = nodename:match(":([a-z_]*)_coral")
			assert(nn_pre, "[Aus] Coral registration: No nodename_stone "
				.. "provided and nodename does not match a known pattern")
			nodename_stone = "australia:coral_stone_" .. nn_pre
		end
	end

	local description = def.description
	assert(description, "Coral needs a description")
	local image = def.image
	assert(image, "Coral needs an image")
	local hard = def.hard
	assert(hard == true or hard == false, "Coral needs a hard/soft boolean")

	local groups, sounds
	if hard then
		groups = {cracky=3, coral=1, stone=1, attached_node=1, sea=1}
		sounds = default.node_sound_stone_defaults()
	else
		groups = {snappy=3, coral=1, attached_node=1, sea=1}
		sounds = default.node_sound_leaves_defaults()
	end

	-- coral_grow will look up this table in the nodetimer. I _think_ this a
	-- better approach than closures.
	coral_growth_targets[nodename_stone] = nodename
	local nn_bleached = def.nodename_bleached or nodename.."_bleached"

	local nodebox = def.node_box or {
		type = "fixed",
		fixed = {-0.40625, -0.40625, -0.40625, 0.40625, 0.375, 0.40625},
	}

	minetest.register_node(nodename, {
		description = description,
		drawtype = def.drawtype or "plantlike",
		waving = 0,
		visual_scale = 1.0,
		tiles = {image},
		inventory_image = image,
		wield_image = image,
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		liquid_move_physics = true,
		move_resistance = 3,
		buildable_to = false,
		drowning = 1,
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		selection_box = nodebox,
		node_box = nodebox,
		collision_box = nodebox,

		-- Keep a timer where we will check if the coral will still live
		on_construct = function(pos)
			local timer = minetest.get_node_timer(pos)
			timer:start(math.random(22,38))
		end,

		-- Die if not kept underwater.
		on_timer = function(pos)
			local above = minetest.get_node(vector.new(pos.x, pos.y+1, pos.z))
			if not iswater(above) then
				minetest.set_node(pos, {name=nn_bleached})
				local below = vector.new(pos.x, pos.y-1, pos.z)
				if minetest.get_node(below).name == nodename_stone then
					minetest.set_node(vector.new(pos.x, pos.y-1, pos.z), {name="default:stone"})
				end
			else
				minetest.get_node_timer(pos):start(math.random(22,38))
			end
		end,

		-- Restart timer of any coral spawning stone below
		on_destruct = function(pos)
			local below = vector.new(pos.x, pos.y-1, pos.z)
			if minetest.get_node(below).name ~= nodename_stone then
				return
			end
			coral_start_timer(below)
		end,

		--[[on_punch = function(pos)
			local tmr = minetest.get_node_timer(pos)
			print(string.format("is_started = %s, timeout = %s", tmr:is_started(), tmr:get_timeout()))
		end--]]
	})

	local desc_bleached = def.desc_bleached or string.format("%s (bleached)", description)
	local image_bleached = def.image_bleached or string.sub(image, 1, -5) .. "_bleached.png"
	minetest.register_node(nn_bleached, {
		description = string.format("%s (bleached)", description),
		drawtype = def.drawtype or "plantlike",
		waving = 0,
		visual_scale = 1.0,
		tiles = {image_bleached},
		inventory_image = image_bleached,
		wield_image = image_bleached,
		paramtype = "light",
		sunlight_propagates = true,
		walkable = true,
		damage_per_second = 1,
		liquid_move_physics = true,
		move_resistance = 7,
		buildable_to = false,
		is_ground_content = true,
		-- All dead corals are hard.. I think
		groups = {cracky=3, coral=1, stone=1, attached_node=1, sea=1},
		sounds = default.node_sound_stone_defaults(),
		selection_box = nodebox,
		node_box = nodebox,
		collision_box = nodebox,
	})

	minetest.register_node(nodename_stone, {
		description = string.format("%s stone", description),
		tiles = {"aus_coral_stone.png"},
		inventory_image = "aus_coral_stone.png^" .. image,
		is_ground_content = true,
		groups = {cracky=3, stone=1},
		drop = "default:stone",
		sounds = sounds,
		on_construct = function(pos)
			local timer = minetest.get_node_timer(pos)
			local min_interval, max_interval = coral_photosynthesis_interval(pos)
			minetest.get_node_timer(pos):start(math.random(min_interval, max_interval))
		end,

		on_timer = function(pos)
			local above = minetest.get_node(vector.new(pos.x, pos.y+1, pos.z))
			if not (iswater(above) or above.name == nodename) then
				minetest.set_node(pos, {name="default:stone"})
			else
				coral_grow(pos, minetest.get_node(pos))
			end
		end,

		--[[on_punch = function(pos)
			local tmr = minetest.get_node_timer(pos)
			print(string.format("is_started = %s, timeout = %s", tmr:is_started(), tmr:get_timeout()))
		end--]]
	})

end

aus.register_coral({
	nodename = "australia:tube_sponge",
	nodename_stone = "australia:coral_stone_tube_sponge",
	description = "Pipestela candelabra: Bob Marley Sponge",
	image = "aus_tube_sponge.png",
	hard = false,
})

aus.register_coral({
	nodename = "australia:brain_coral",
	description = "Dipsastraea speciosa: Brain Coral",
	image = "aus_brain_coral.png",
	hard = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, 0.4375, 0.1875},
			{-0.25, -0.5, -0.25, 0.25, 0.375, 0.25},
			{-0.3125, -0.5, -0.3125, 0.3125, 0.3125, 0.3125},
			{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375},
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.1875, 0.4375},
			{-0.5, -0.375, -0.5, 0.5, 0.125, 0.5},
		}
	},
})

-- Show the nodebox not the flat texture. Refactor register_coral if more
-- nodebox-corals are ever needed.
minetest.override_item("australia:brain_coral", { inventory_image = "", })

for i, colour in pairs({"green", "orange", "purple"}) do
	aus.register_coral({
		nodename = string.format("australia:cluster_coral_%s", colour),
		nodename_bleached = "australia:cluster_coral_bleached",
		desc_bleached = "Acropora millepora: Cluster Coral (bleached)",
		description = string.format(
			"Acropora millepora: Cluster Coral (%s)", colour),
		image = string.format("aus_cluster_coral_%s.png", colour),
		image_bleached = "aus_cluster_coral_bleached.png",
		hard = true,
	})
end

aus.register_coral({
	nodename = "australia:hammer_coral",
	description = "Euphyllia ancora: Hammer coral",
	image = "aus_hammer_coral.png",
	hard = true,
})

aus.register_coral({
	nodename = "australia:seafan_coral",
	description = "Acabaria splendens: Sea Fan",
	image = "aus_seafan_coral.png",
	hard = false,
})

for i, colour in pairs({"brown", "green", "pink"}) do
	aus.register_coral({
		nodename = string.format("australia:cauliflower_coral_%s", colour),
		nodename_bleached = "australia:cauliflower_coral_bleached",
		desc_bleached = "Pocillopora damicornis: Cauliflower Coral (bleached)",
		description = string.format(
			"Pocillopora damicornis: Cauliflower Coral (%s)", colour),
		image = string.format("aus_cauliflower_coral_%s.png", colour),
		image_bleached = "aus_cauliflower_coral_bleached.png",
		hard = true,
	})
end

for i, colour in pairs({"blue", "pink", "purple", "yellow"}) do
	aus.register_coral({
		nodename = string.format("australia:staghorn_coral_%s", colour),
		nodename_bleached = "australia:staghorn_coral_bleached",
		desc_bleached = "Acropora cervicornis: Staghorn Coral (bleached)",
		description = string.format(
			"Acropora cervicornis: Staghorn Coral (%s)", colour),
		image = string.format("aus_staghorn_coral_%s.png", colour),
		image_bleached = "aus_staghorn_coral_bleached.png",
		hard = true,
	})
end

local lbm_targets = {}
for stone, coral in pairs(coral_growth_targets) do
	table.insert(lbm_targets, stone)
end

minetest.register_lbm({
	label = "Ensure aussie coral growth",
	name = "australia:ensure_coral_growth",
	nodenames = lbm_targets,
	-- It does not seem we can remove this, because we rely on it to spawn
	-- corals at worldgen time as well as upgrade old corals.
	run_at_every_load = true,
	action = function(pos, node)
		local timer = minetest.get_node_timer(pos)
		if not timer:is_started() then
			coral_grow(pos, node, true)
		end
	end,
})

aus.coral_growth_targets = coral_growth_targets
