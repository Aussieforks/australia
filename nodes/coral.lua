-- aus/nodes/coral.lua
-- Corals and other nodes that grow from stony beds on the sea floor.

local coral_growth_targets = {}
local MIN_CORAL_INTERVAL = 180 --5
local MAX_CORAL_INTERVAL = 300 --25

local function coral_grow(pos, node)
	print(string.format("Running coral_grow @ %s", pos))
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "australia:water_source") then
		print("Replacing coral...")
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = coral_growth_targets[node.name]})
	else
		print("Deferring coral replacement...")
		minetest.get_node_timer(pos):start(math.random(MIN_CORAL_INTERVAL, MAX_CORAL_INTERVAL))
	end
end

--[[
Register a coral species and its spawning stone. The stone must be registered 
to appropriate biomes as an ore separately for it to appear in the world.
A ? after the property name means it is optional
CoralDef = {
	nodename = "australia:"..., -- the coral 
	nodename_stone?, -- defaults to a pattern based on nodename, as in 
		e.g. hammer_coral or staghorn_coral_blue
	image = "*.png", -- the coral's inventory image
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
		print(nodename)
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
	if nodename_stone == nil then
		dbg()
	end
	coral_growth_targets[nodename_stone] = nodename

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
		climbable = true,
		buildable_to = false,
		drowning = 1,
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		selection_box = def.node_box or {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
		},
		node_box = def.node_box,
		collision_box = def.node_box,
		on_destruct = function(pos)
			local below = vector.new(pos.x, pos.y-1, pos.z)
			if minetest.get_node(below).name == nodename_stone then
				minetest.get_node_timer(below):start(math.random(MIN_CORAL_INTERVAL, MAX_CORAL_INTERVAL))
			end
		end,
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
			print(("%s starting timer via on_construct"):format(nodename_stone))
			local timer = minetest.get_node_timer(pos)
			print(timer:start(math.random(MIN_CORAL_INTERVAL, MAX_CORAL_INTERVAL)) == nil)
		end,

		on_timer = function(pos)
			print(("%s running on_timer"):format(nodename_stone))
			coral_grow(pos, minetest.get_node(pos)) 
		end,

		on_punch = function(pos, node, puncher, pointed_thing)
			print(pos, dump(node), node, minetest.get_node_timer(pos):is_started())
		end,
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

for i, colour in pairs({"green", "orange", "purple"}) do
	aus.register_coral({
		nodename = string.format("australia:cluster_coral_%s", colour),
		description = string.format(
			"Acropora millepora: Cluster Coral (%s)", colour),
		image = string.format("aus_cluster_coral_%s.png", colour),
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
		description = string.format(
			"Pocillopora damicornis: Cauliflower Coral (%s)", colour),
		image = string.format("aus_cauliflower_coral_%s.png", colour),
		hard = true,
	})
end

for i, colour in pairs({"blue", "pink", "purple", "yellow"}) do
	aus.register_coral({
		nodename = string.format("australia:staghorn_coral_%s", colour),
		description = string.format(
			"Acropora cervicornis: Staghorn Coral (%s)", colour),
		image = string.format("aus_staghorn_coral_%s.png", colour),
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
	run_at_every_load = true,
	action = function(pos, node)
		print("Running coral LBM..")
		local timer = minetest.get_node_timer(pos)
		if not timer:is_started() then
			print(timer:start(math.random(MIN_CORAL_INTERVAL, MAX_CORAL_INTERVAL)) == nil)
			print(("%s starting timer via lbm @ "):format(node.name, pos))
		else
			print(("%s already had timer started via lbm"):format(node.name))
		end
	end,
})

aus.coral_growth_targets = coral_growth_targets
