
if script.level.campaign_name then return end
if script.level.level_name == "sandbox" then return end
if script.level.level_name == "pvp" then return end
if script.level.level_name == "team-production" then return end
if script.level.level_name == "rocket-rush" then return end
if script.level.level_name == "wave-defence" then return end
if remote.interfaces["disable-" .. script.level.mod_name] then return end


local M = {}


local force_util = require("zk-static-lib/lualibs/control_stage/force-util")


local multiplier = settings.global["sh-item-multiplier"].value
local hours = settings.global["sh-hours"].value
---@cast hours number
local ceil = math.ceil
local start_items
local important_items
local start_equipments


---@param to table
---@param from table
local function join_with_multiplier(to, from)
	for _, value in pairs(from) do
		to[#to+1] = {value[1], ceil(value[2] * multiplier)}
	end
end

local function get_start_items()
	start_items = {}
	start_equipments = {}
	important_items = {}

	if script.active_mods.IndustrialRevolution3 then return end -- temporary
	if hours == 0 then return end

	if hours >= 1 then
		join_with_multiplier(start_items, {
			{"coal", 40},
			{"wood", 40},
			{"copper-plate", 25},
			{"transport-belt", 150},
			{"underground-belt", 20},
			{"splitter", 10},
			{"small-electric-pole", 14},
			{"stone-furnace", 15},
			{"assembling-machine-1", 5},
			{"stone", 50},
			{"wooden-chest", 5},
			{"offshore-pump", 1},
			{"small-lamp", 10},
		})
		join_with_multiplier(important_items, {
			{"shotgun-shell", 8},
		})
		if not script.active_mods.IndustrialRevolution3 then
			join_with_multiplier(start_items, {
				{"radar", 1},
				{"pipe", 20},
				{"pipe-to-ground", 2},
				{"boiler", 2},
				{"iron-chest", 6},
				{"inserter", 30},
				{"iron-plate", 55},
				{"steam-engine", 4},
				{"electronic-circuit", 10},
				{"iron-gear-wheel", 40},
				{"stone-wall", 60},
				{"lab", 1},
			})
			join_with_multiplier(important_items, {
				{"firearm-magazine", 20},
				{"repair-pack", 10},
			})
		end
		if hours == 1 then
			important_items[#important_items+1] = {"shotgun", 1}
			join_with_multiplier(important_items, {
				{"shotgun-shell", 8},
			})

			if script.active_mods.IndustrialRevolution3 then
				join_with_multiplier(start_items, {
					{"small-assembler-1", 10},
					{"copper-lab", 1},
				})
			end
		end
	end

	if hours >= 2 then
		if not script.active_mods.IndustrialRevolution3 then
			join_with_multiplier(start_items, {
				{"electric-mining-drill", 8},
			})
		end
		join_with_multiplier(start_items, {
			{"medium-electric-pole", 5},
			{"gate", 10},
			{"steel-plate", 12},
			{"rail", 150},
			{"locomotive", 1},
			{"cargo-wagon", 2},
			{"rail-signal", 5},
			{"rail-chain-signal", 5},
			{"train-stop", 2},
			{"steel-chest", 5},
			{"long-handed-inserter", 20},
			{"fast-transport-belt", 150},
			{"fast-underground-belt", 20},
			{"fast-splitter", 10},
			{"engine-unit", 6},
			{"substation", 6},
		})
		join_with_multiplier(important_items, {
			{"piercing-rounds-magazine", 10},
			{"piercing-shotgun-shell", 8},
		})
		important_items[#important_items+1] = {"submachine-gun", 1}
		important_items[#important_items+1] = {"combat-shotgun", 1}
		important_items[#important_items+1] = {"car", 1}
		important_items[#important_items+1] = {"grenade", 10}
		important_items[#important_items+1] = {"slowdown-capsule", 5}
		important_items[#important_items+1] = {"poison-capsule", 5}
		if hours == 2 then
			start_items[#start_items+1] = {"stone-brick", 1000}
		end
	else
		return
	end

	if hours >= 5 then
		join_with_multiplier(start_items, {
			{"big-electric-pole", 5},
			{"pumpjack", 3},
			{"concrete", 1000},
			{"fast-inserter", 15},
			{"filter-inserter", 8},
			{"advanced-circuit", 10},
			{"assembling-machine-2", 8},
			{"oil-refinery", 1},
			{"chemical-plant", 5},
			{"steel-furnace", 10},
			{"storage-tank", 3},
		})
		join_with_multiplier(important_items, {
			{"land-mine", 10},
			{"cluster-grenade", 10},
			{"flamethrower-ammo", 10},
			{"rocket-fuel", 5},
			{"cliff-explosives", 5},
			{"rocket", 8},
		})
		important_items[#important_items+1] = {"rocket-launcher", 1}
		important_items[#important_items+1] = {"flamethrower", 1}
		start_equipments[#start_equipments+1] = {"night-vision-equipment", 1}
		if hours >= 5 then
			start_equipments[#start_equipments+1] = {"solar-panel-equipment", 4}
			start_equipments[#start_equipments+1] = {"battery-equipment", 1}
		end
	else
		return
	end

	if hours >= 8 then
		join_with_multiplier(start_items, {
			{"express-transport-belt", 150},
			{"express-underground-belt", 20},
			{"express-splitter", 10},
			{"processing-unit", 10},
			{"electric-engine-unit", 6},
			{"assembling-machine-3", 8},
			{"electric-furnace", 10},
			{"roboport", 1},
			{"logistic-robot", 12},
			{"beacon", 4},
			{"construction-robot", 12},
		})
		important_items[#important_items+1] = {"tank", 1}
		if hours == 8 then
			start_equipments[#start_equipments+1] = {"personal-roboport-equipment", 1}
			start_equipments[#start_equipments+1] = {"fusion-reactor-equipment", 1}
		end
	else
		return
	end

	if hours >= 10 then
		join_with_multiplier(important_items, {
			{"nuclear-fuel", 1},
			{"uranium-rounds-magazine", 15},
		})
		important_items[#important_items+1] = {"spidertron", 1}
		start_equipments[#start_equipments+1] = {"exoskeleton-equipment", 1}
		if hours == 10 then
			start_equipments[#start_equipments+1] = {"personal-roboport-mk2-equipment", 1}
			start_equipments[#start_equipments+1] = {"fusion-reactor-equipment", 2}
		end
	else
		return
	end
end
get_start_items()


---@param force LuaForce
---@param hours number
function M.research_techs(force, hours)
	if hours == 0 then return end
	if script.active_mods.IndustrialRevolution3 then return end

	local tech_items = {}
	local max_research_unit_count = 100
	local item_prototypes = prototypes.item
	local function add_to_tech_items(item_name)
		if item_prototypes[item_name] then
			tech_items[#tech_items+1] = item_name
		end
	end
	if hours >= 1 then
		add_to_tech_items("automation-science-pack")
	end
	if hours >= 2 then
		add_to_tech_items("logistic-science-pack")
		max_research_unit_count = 250
	end
	if hours >= 5 then
		add_to_tech_items("military-science-pack")
		add_to_tech_items("chemical-science-pack")
		max_research_unit_count = 510
	end
	if hours >= 8 then
		add_to_tech_items("production-science-pack")
		max_research_unit_count = 1100
	end
	if hours >= 10 then
		add_to_tech_items("utility-science-pack")
		max_research_unit_count = 1300
	end

	force_util.research_enabled_techs_by_items(force, tech_items, max_research_unit_count)
end


---@return string?
local function get_start_armor()
	local start_armor
	if hours >= 10 then
		start_armor = "power-armor-mk2"
		if prototypes.item[start_armor] then return start_armor end
	end
	if hours >= 8 then
		start_armor = "power-armor"
		if prototypes.item[start_armor] then return start_armor end
	end
	if hours >= 5 then
		start_armor = "modular-armor"
		if prototypes.item[start_armor] then return start_armor end
	end
	if hours >= 2 then
		start_armor = "heavy-armor"
		if prototypes.item[start_armor] then return start_armor end
	end
	if hours >= 1 then
		start_armor = "light-armor"
		if prototypes.item[start_armor] then return start_armor end
	end
end


---@return string?
local function find_chest()
	local chest_name = "steel-chest"
	if prototypes.entity[chest_name] then return chest_name end
	log("Starting chest " .. chest_name .. " is not a valid entity prototype, picking a new container from prototype list")

	for name, chest in pairs(prototypes.entity) do
		if chest.type == "container" then
			return name
		end
	end
end


---@param target LuaEntity|LuaPlayer
---@param all_items table<any, table>
local function insert_items(target, all_items)
	local init_position = target.position
	local neutral_force = game.forces.neutral
	local surface = target.surface
	local items = {name = '', count = 0}
	for _, item in pairs(all_items) do
		if prototypes.item[item[1]] then
			items.name = item[1]
			items.count = item[2]
			while items.count > 0 do
				local inserted_count = target.insert(items)
				if inserted_count > 0 then
					items.count = items.count - inserted_count
				else
					local container_name = find_chest() -- this is dirty
					local position = surface.find_non_colliding_position(container_name, init_position, 100, 1.5)
					if position == nil then
						log("Can't find non colliding position for " .. container_name)
						return
					end
					target = surface.create_entity{name = container_name, position = position, force = neutral_force, create_build_effect_smoke = false}
				end
			end
		else
			log("\"" .. item[1] .. "\" doesn't exist in the game, please check spelling.")
		end
	end
end


---@param player LuaPlayer
local function insert_personal_items(player)
	local start_armor = get_start_armor()
	if start_armor then
		local item_prototypes = prototypes.item
		local armor_inventory = player.get_inventory(defines.inventory.character_armor)
		if not (armor_inventory and armor_inventory.valid and armor_inventory.can_insert(start_armor)) then
			goto skip
		end
		armor_inventory.insert(start_armor)
		local armor_grid = armor_inventory.find_item_stack(start_armor).grid
		if not (armor_grid and armor_grid.valid and start_equipments) then
			goto skip
		end
		for _, v in pairs(start_equipments) do
			if item_prototypes[v[1]] then
				for _=1, v[2], 1 do
					armor_grid.put{name = v[1]}
				end
			end
		end
	end

	:: skip ::
	insert_items(player, important_items)
end


local function on_game_created_from_freeplay()
	storage.is_init = true
	local surface = game.get_surface(1)
	if not (surface and surface.valid) then return end

	M.research_techs(game.forces.player, hours)
	if script.active_mods.IndustrialRevolution3 then return end -- temporary

	local neutral_force = game.forces["neutral"]
	local container_name, position
	local target = surface.find_entities_filtered{position = {0, 0}, radius = 100, name = "crash-site-spaceship", type = "container"}[1]
	if target and target.valid then
		container_name = target.name
		position = target.position
	else
		container_name = find_chest()
		position = surface.find_non_colliding_position(container_name, {0, 0}, 100, 1)
		if position == nil then
			log("Can't find non colliding position for " .. container_name)
			return
		end
		target = surface.create_entity{name = container_name, position = position, force = neutral_force, create_build_effect_smoke = false}
	end

	storage.is_freeplay_game = true

	local start_armor = get_start_armor()
	if start_armor then
		target.insert(start_armor)
	end

	insert_items(target, start_equipments)
	insert_items(target, important_items)
	insert_items(target, start_items)
end


---@param event EventData.on_player_created
local function on_player_created_straight(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then return end

	insert_personal_items(player)
	insert_items(player, start_items)
end


---@param event EventData.on_player_created
local function on_freeplayer_created(event)
	if hours == 0 then return end
	if storage.is_freeplay_game then
		local player = game.get_player(event.player_index)
		if not (player and player.valid) then return end
		insert_personal_items(player)
		return
	end
	if storage.is_init ~= true then
		on_game_created_from_freeplay()
		if storage.is_freeplay_game then return end
	end

	on_player_created_straight(event)
end


---@param event EventData.on_runtime_mod_setting_changed
local function on_runtime_mod_setting_changed(event)
	if event.setting_type ~= "runtime-global" then return end

	local setting_name = event.setting
	if setting_name == "sh-item-multiplier" then
		multiplier = settings.global[setting_name].value
		get_start_items()
	elseif setting_name == "sh-hours" then
		hours = settings.global[setting_name].value
		get_start_items()
	end
end

function on_init()
	if remote.interfaces["freeplay"] then
		remote.call("freeplay", "set_skip_intro", true) -- Does it work?
	end
end


script.on_event(defines.events.on_runtime_mod_setting_changed, on_runtime_mod_setting_changed)

if script.level.level_name == "freeplay" then
	script.on_init(on_init)
	script.on_event(defines.events.on_player_created, on_freeplayer_created)
else
	script.on_event(defines.events.on_player_created, function(event)
		if hours == 0 then return end
		on_player_created_straight(event)
	end)
end


return M
