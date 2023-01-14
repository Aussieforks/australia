-- noairblocks (legacy compatibility)
-- Previously this code caused the death of aquatic plantlife if it was exposed
-- to air. Nodetimers are now used for that effect; see
-- nodes/init.lua, nodes/plantlife_aquatic.lua and so on.
-- These aliases are left to upgrade old versions in backwards-compatible
-- fashion.

local water_nodes = {"default:water_source", "default:water_flowing", "default:river_water_source", "default:river_water_flowing"}
local aus_nodes = {"australia:water_source", "australia:water_flowing", "australia:river_water_source", "australia:river_water_flowing"}

for idx, node in pairs(aus_nodes) do
	print(string.format("[aus] Registering alias: %s -> %s",
			node, water_nodes[idx]))
	minetest.register_alias(node, water_nodes[idx])
end
