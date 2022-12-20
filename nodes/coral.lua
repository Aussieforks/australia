-- aus/nodes/coral.lua
-- Corals and other nodes that grow from stony beds on the sea floor.
local pa = aus.plantlife_aquatic

local growth_targets = pa.growth_targets
local iswater = aus.iswater

local photosynthesis_interval = pa.photosynthesis_interval
local coral_start_timer = pa.start_timer
local coral_grow = pa.grow

--[[
Register a coral species and its spawning stone. The stone must be registered
to appropriate biomes as an ore separately for it to appear in the world.
A ? after the property name means it is optional
CoralDef = {
	nodename = "australia:"..., -- the coral
	nodename_stone? = "australia:, -- defaults to a pattern based on nodename,
		as in e.g. hammer_coral or staghorn_coral_blue
	nodename_dead? = "australia:"... -- defaults to a suffix based on
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
	growth_targets[nodename_stone] = nodename
	local nn_bleached = def.nodename_dead or nodename.."_bleached"

	local nodebox = def.node_box or {
		type = "fixed",
		fixed = {-0.40625, -0.40625, -0.40625, 0.40625, 0.375, 0.40625},
	}

	local base_def = table.copy(pa.aquatic_life_base_def)
	base_def.description = description
	base_def.drawtype = def.drawtype or base_def.drawtype
	base_def.tiles = {image}
	base_def.inventory_image = image
	base_def.wield_image = image
	base_def.groups = groups
	base_def.sounds = sounds
	base_def.on_timer = pa.base_def_on_timer_closure(nn_bleached, nodename_stone)
	base_def.on_destruct = pa.base_def_on_destruct_closure(nodename_stone)
	--[[base_def.on_punch = function(pos)
		local tmr = minetest.get_node_timer(pos)
		print(string.format("is_started = %s, timeout = %s", tmr:is_started(), tmr:get_timeout()))
	end--]]
	minetest.register_node(nodename, base_def)

	local desc_bleached = def.desc_bleached or string.format("%s (bleached)", description)
	local image_bleached = def.image_bleached or string.sub(image, 1, -5) .. "_bleached.png"
	local bleached_def = table.copy(pa.aquatic_life_base_def)
	bleached_def.description = desc_bleached
	bleached_def.drawtype = def.drawtype or base_def.drawtype
	bleached_def.waving = 0
	bleached_def.tiles = {image_bleached}
	bleached_def.inventory_image = image_bleached
	bleached_def.wield_image = image_bleached
	bleached_def.walkable = true
	bleached_def.damage_per_second = 1
	bleached_def.liquid_move_physics = true
	bleached_def.drowning = 0
	bleached_def.move_resistance = 7
	-- All dead corals are hard.. I think
	bleached_def.groups = {cracky=3, coral=1, stone=1, attached_node=1, sea=1}
	bleached_def.sounds = default.node_sound_stone_defaults()
	minetest.register_node(nn_bleached, bleached_def)

	local stone_def = table.copy(pa.stone_basedef)
	stone_def.description = string.format("%s stone", description)
	stone_def.inventory_image = stone_def.inventory_image .. image
	stone_def.on_timer = pa.stone_basedef_on_timer_closure(nodename)
	--[[stone_def.on_punch = function(pos)
		local tmr = minetest.get_node_timer(pos)
		print(string.format("is_started = %s, timeout = %s", tmr:is_started(), tmr:get_timeout()))
	end--]]

	minetest.register_node(nodename_stone, stone_def)
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

for _, colour in pairs({"green", "orange", "purple"}) do
	aus.register_coral({
		nodename = string.format("australia:cluster_coral_%s", colour),
		nodename_dead = "australia:cluster_coral_bleached",
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

for _, colour in pairs({"brown", "green", "pink"}) do
	aus.register_coral({
		nodename = string.format("australia:cauliflower_coral_%s", colour),
		nodename_dead = "australia:cauliflower_coral_bleached",
		desc_bleached = "Pocillopora damicornis: Cauliflower Coral (bleached)",
		description = string.format(
			"Pocillopora damicornis: Cauliflower Coral (%s)", colour),
		image = string.format("aus_cauliflower_coral_%s.png", colour),
		image_bleached = "aus_cauliflower_coral_bleached.png",
		hard = true,
	})
end

for _, colour in pairs({"blue", "pink", "purple", "yellow"}) do
	aus.register_coral({
		nodename = string.format("australia:staghorn_coral_%s", colour),
		nodename_dead = "australia:staghorn_coral_bleached",
		desc_bleached = "Acropora cervicornis: Staghorn Coral (bleached)",
		description = string.format(
			"Acropora cervicornis: Staghorn Coral (%s)", colour),
		image = string.format("aus_staghorn_coral_%s.png", colour),
		image_bleached = "aus_staghorn_coral_bleached.png",
		hard = true,
	})
end