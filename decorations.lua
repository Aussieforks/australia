function aus.biome_register_grass_decorations(decos, biome, place_on, grassnode)
	for idx, deco in pairs(decos) do
		local offset = deco[1]
		local scale = deco[2]
		local length = deco[3]
		minetest.register_decoration({
			deco_type = "simple",
			place_on = place_on,
			sidelen = 16,
			noise_params = {
				offset = offset,
				scale = scale,
				spread = {x = 200, y = 200, z = 200},
				seed = 329,
				octaves = 3,
				persist = 0.6
			},
			biomes = {biome},
			y_min = 4,
			y_max = 35,
			decoration = grassnode..tostring(length),
		})
	end
end
