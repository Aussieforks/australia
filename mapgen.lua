-- mods/australia/mapgen.lua

if minetest.settings:get_bool("australia.clear_biomes", true) then
	minetest.clear_registered_biomes()
end
if minetest.settings:get_bool("australia.clear_decorations", true) then
	minetest.clear_registered_decorations()
end
if minetest.settings:get_bool("australia.clear_ores", true) then
	minetest.clear_registered_ores()
end

--
-- Register ores
--
-- Used to copy default's code - now will just use its API

if minetest.settings:get_bool("australia.reregister_ores", true) then
	if mg_name == "v6" then
		default.register_mgv6_ores()
	else
		default.register_ores()
	end
end

--
-- Biomes
--

local mgname = minetest.get_mapgen_setting("mg_name")
local snowline
local biome_ymax
if mgname == "valleys" then
	function aus.snowline()
		return 150
	end
	function aus.biome_ymax()
		return 31000
	end
else
	-- y=120 chosen based on Aussieforks settings for carpathian to place snow on
	-- taller mountains.
	snowline = 120
	if minetest.settings:get_bool("australia.enable_biome_australia_alps", true) then
		local _snowline = tonumber(minetest.settings:get("australia.snowline"))
		if _snowline ~= nil then
			snowline = _snowline
		end
	end
	function aus.snowline()
		return snowline
	end
	function aus.biome_ymax()
		return snowline
	end
end

aus.biomes = {
	-- Underground Biomes
	"underground",
	-- Coastal Biomes
	"mangroves",
	"tasman_sea",
	"great_australian_bight",
	"indian_ocean",
	"great_barrier_reef",
	"timor_sea",
	-- Lowlands Biomes
	"jarrah_karri_forests",
	"eastern_coasts",
	"goldfields_esperence",
	"arnhem_land",
	"gulf_of_carpentaria",
	"far_north_queensland",
	"pilbara",
	"kimberley",
	-- Highland Biomes
	"tasmania",
	"great_dividing_range",
	"victorian_forests",
	"flinders_lofty",
	"murray_darling_basin",
	"mulga_lands",
	"central_australia",
	"simpson_desert",
	-- Apline Biomes
	"australian_alps"
}

aus.active_biomes = {}

for _,biome in pairs(aus.biomes) do
	if minetest.settings:get_bool("australia.enable_biome_"..biome,true) then
		dofile(aus.path.. "/biome_"..biome..".lua")
		aus.active_biomes[biome] = true
		minetest.log("info", "Australia: biome ".. biome.." loaded")
	end
end
