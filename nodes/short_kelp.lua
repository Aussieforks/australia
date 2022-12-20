-- aus/nodes/coral.lua
-- Corals and other nodes that grow from stony beds on the sea floor.
local pa = aus.plantlife_aquatic

local growth_targets = pa.growth_targets
local iswater = aus.iswater

local photosynthesis_interval = pa.photosynthesis_interval
local coral_start_timer = pa.start_timer
local coral_grow = pa.grow

--[[
Register a short kelp species and its spawning stone. The stone must be
registered to appropriate biomes as an ore separately for it to appear in the
world. A ? after the property name means it is optional
ShortKelpDef = {
	nodename = "australia:"..., -- the coral
	nodename_stone? = "australia:, -- defaults to prefixing nodename with :_stone
	nodename_dead? = "australia:"... -- defaults to a suffix based on
		nodename, but can be overriden for e.g. groups of colour varieties
	image = "*.png", -- the coral's inventory image. .JPEG is NOT supported
		without providing an explicit image_dead. (use .jpg instead)
	image_dead = "*.png" -- the image to use when the plant dies due to lack of
        water
	drawtype?, -- the coral's drawtype (to support nodeboxes instead of
        plantlikes)
	nodebox?, -- for nodebox drawtype, the nodebox definition
}
--]]
function aus.register_short_kelp(def)
	local nodename = def.nodename
	assert(nodename, "Short kelp needs nodename")

	local nodename_stone = def.nodename_stone
	if not nodename_stone then
        local colonidx = nodename:find(":")
        assert(colonidx, string.format("No colon found in nodename: %s", nodename))

        -- Prefix the part after the colon with 'stone_'
        nodename_stone = nodename:sub(0, colonidx) .. 'stone_' ..
            nodename:sub(colonidx+1,-1)
	end

	local description = def.description
	assert(description, "Short kelp needs a description")
	local image = def.image
	assert(image, "Short kelp needs an image")

    local groups = {snappy=3, coral=1, attached_node=1, sea=1}
    local sounds = default.node_sound_leaves_defaults()

	-- grow will look up this table in the nodetimer. I _think_ this a
	-- better approach than closures.
	growth_targets[nodename_stone] = nodename
	local nn_dead = def.nodename_dead or nodename.."_dead"

	local nodebox = def.node_box or {
		type = "fixed",
		fixed = {-0.40625, -0.40625, -0.40625, 0.40625, 0.375, 0.40625},
	}

	minetest.register_node(nodename, {
		description = description,
		drawtype = def.drawtype or "plantlike",
		waving = 1,
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
				minetest.set_node(pos, {name=nn_dead})
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

	local desc_dead = def.desc_dead or string.format("%s (dead)", description)
	local image_dead = def.image_dead or string.sub(image, 1, -5) .. "_dead.png"
	minetest.register_node(nn_dead, {
		description = desc_dead,
		drawtype = def.drawtype or "plantlike",
		waving = 0,
		tiles = {image_dead},
		inventory_image = image_dead,
		wield_image = image_dead,
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
			local min_interval, max_interval = photosynthesis_interval(pos)
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

minetest.register_abm({
	nodenames = {"australia:stone_kelp_brown"},
	interval = 15,
	chance = 5,
	action = function(pos)--, node, active_object_count, active_object_count_wider)
		local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node(yp).name == "default:water_source" or
			minetest.get_node(yp).name == "australia:water_source")
		then
			pos.y = pos.y + 1
			minetest.add_node(pos, {name = "australia:kelp_brown"})
		else
			return
		end
	end
})

-- Ecklonia radiata: Common Kelp
minetest.register_node("australia:kelp_brown", {
	description = "Ecklonia radiata: Common Kelp",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"aus_kelp_brown.png"},
	inventory_image = "aus_kelp_brown.png",
	wield_image = "aus_kelp_brown.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy=3, seaplants=1, sea=1, food_seaweed=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

minetest.register_node("australia:stone_kelp_brown", {
	description = "Ecklonia radiata: Common Kelp stone",
	tiles = {"aus_coral_stone.png"},
	inventory_image = "aus_coral_stone.png^aus_kelp_brown.png",
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})
