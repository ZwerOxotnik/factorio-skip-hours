
if script.level.campaign_name then return end
if script.level.level_name == "sandbox" then return end
if script.level.level_name == "pvp" then return end
if script.level.level_name == "team-production" then return end
if script.level.level_name == "rocket-rush" then return end
if script.level.level_name == "wave-defence" then return end
if remote.interfaces["disable-" .. script.level.mod_name] then return end


local multiplier = settings.global["sh-item-multiplier"].value
local hours = settings.global["sh-hours"].value
local ceil = math.ceil
local start_items
local important_items
local start_equipments


---@param to table
---@param from table
local function join(to, from)
	for _, value in pairs(from) do
		to[#to+1] = {value[1], ceil(value[2] * multiplier)}
	end
end

---@return table
local function get_start_items()
	if hours == 0 then return {} end

	start_items = {}
	start_equipments = {}
	important_items = {}

	if hours >= 1 then
		join(start_items, {
			{"iron-plate", 55},
			{"coal", 40},
			{"wood", 40},
			{"copper-plate", 25},
			{"electronic-circuit", 10},
			{"iron-gear-wheel", 40},
			{"iron-chest", 6},
			{"inserter", 10},
			{"transport-belt", 50},
			{"underground-belt", 8},
			{"splitter", 6},
			{"small-electric-pole", 14},
			{"electric-mining-drill", 8},
			{"stone-furnace", 10},
			{"assembling-machine-1", 5},
			{"pipe", 20},
			{"pipe-to-ground", 2},
			{"stone", 50},
			{"wooden-chest", 5},
			{"steam-engine", 4},
			{"boiler", 2},
			{"offshore-pump", 1},
			{"lab", 1},
			{"radar", 1},
			{"small-lamp", 10},
			{"stone-wall", 60},
		})
		join(important_items, {
			{"firearm-magazine", 20},
			{"repair-pack", 10},
			{"shotgun-shell", 8},
		})
		if hours == 1 then
			important_items[#important_items+1] = {"shotgun", 1}
			join(important_items, {
				{"shotgun-shell", 8},
			})
		end
	end

	if hours >= 2 then
		join(start_items, {
			{"medium-electric-pole", 5},
			{"gate", 10},
			{"steel-plate", 10},
			{"rail", 150},
			{"locomotive", 1},
			{"cargo-wagon", 2},
			{"rail-signal", 5},
			{"rail-chain-signal", 5},
			{"train-stop", 2},
			{"steel-chest", 5},
			{"fast-transport-belt", 40},
			{"fast-underground-belt", 8},
			{"fast-splitter", 6},
			{"fast-inserter", 10},
			{"filter-inserter", 5},
			{"engine-unit", 6},
			{"substation", 6},
		})
		join(important_items, {
			{"piercing-rounds-magazine", 10},
			{"piercing-shotgun-shell", 8},
			{"rocket", 8},
		})
		important_items[#important_items+1] = {"submachine-gun", 1}
		important_items[#important_items+1] = {"combat-shotgun", 1}
		important_items[#important_items+1] = {"rocket-launcher", 1}
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
		join(start_items, {
			{"big-electric-pole", 5},
			{"pumpjack", 3},
			{"concrete", 1000},
			{"advanced-circuit", 10},
			{"assembling-machine-2", 8},
			{"oil-refinery", 1},
			{"chemical-plant", 5},
			{"steel-furnace", 10},
			{"storage-tank", 3},
		})
		join(important_items, {
			{"land-mine", 10},
			{"cluster-grenade", 10},
			{"flamethrower-ammo", 10},
			{"rocket-fuel", 5},
			{"cliff-explosives", 5},
		})
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
		join(start_items, {
			{"express-transport-belt", 40},
			{"express-underground-belt", 8},
			{"express-splitter", 6},
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
		join(important_items, {
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

local function get_start_armor()
	local start_armor
	if hours >= 10 then
		start_armor = "power-armor-mk2"
		if game.item_prototypes[start_armor] then return start_armor end
	end
	if hours >= 8 then
		start_armor = "power-armor"
		if game.item_prototypes[start_armor] then return start_armor end
	end
	if hours >= 5 then
		start_armor = "modular-armor"
		if game.item_prototypes[start_armor] then return start_armor end
	end
	if hours >= 2 then
		start_armor = "heavy-armor"
		if game.item_prototypes[start_armor] then return start_armor end
	end
	if hours >= 1 then
		start_armor = "light-armor"
		if game.item_prototypes[start_armor] then return start_armor end
	end
end

local function find_chest()
	local chest_name = "steel-chest"
	if game.entity_prototypes[chest_name] then return chest_name end
	log("Starting chest " .. chest_name .. " is not a valid entity prototype, picking a new container from prototype list")

	for name, chest in pairs(game.entity_prototypes) do
		if chest.type == "container" then
			return name
		end
	end
end

local function insert_items(target, all_items)
	local position = target.position
	local neutral_force = game.forces["neutral"]
	local surface = target.surface
	for _, item in pairs(all_items) do
		if game.item_prototypes[item[1]] then
			local items = {name = item[1], count = item[2]}
			if target.can_insert(items) then
				target.insert(items) -- TODO: check inserted count of items
			else
				local container_name = find_chest() -- this is dirty
				position = surface.find_non_colliding_position(container_name, position, 30, 1)
				if position == nil then
					log("Can't find non colliding position for " .. container_name)
					return
				end
				target = surface.create_entity{name = container_name, position = position, force = neutral_force, create_build_effect_smoke = false}
			end
		else
			log("\"" .. item[1] .. "\" doesn't exist in the game, please check spelling.")
		end
	end
end

local function insert_personal_items(player)
	local start_armor = get_start_armor()
	if start_armor then
		local armor_inventory = player.get_inventory(defines.inventory.character_armor)
		if armor_inventory.can_insert(start_armor) then
			armor_inventory.insert(start_armor)
			local armor_grid = armor_inventory.find_item_stack(start_armor).grid
			if armor_grid and start_equipments then
				for _, v in pairs(start_equipments) do
					if game.item_prototypes[v[1]] then
						for i=1, v[2], 1 do
							armor_grid.put{name = v[1]}
						end
					end
				end
			end
		end
	end

	insert_items(player, important_items)
end


local function on_game_created_from_freeplay()
	global.is_init = true
	local surface = game.get_surface(1)
	if not (surface and surface.valid) then return end

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

	global.is_freeplay_game = true

	local start_armor = get_start_armor()
	if start_armor then
		target.insert(start_armor)
	end

	insert_items(target, start_equipments)
	insert_items(target, important_items)
	insert_items(target, start_items)
end

local function on_player_created_straight(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then return end

	insert_personal_items(player)
	insert_items(player, start_items)
end

---@param event table
local function on_freeplayer_created(event)
	if hours == 0 then return end
	if global.is_freeplay_game then
		local player = game.get_player(event.player_index)
		if not (player and player.valid) then return end
		insert_personal_items(player)
		return
	end
	if global.is_init ~= true then
		on_game_created_from_freeplay()
		if global.is_freeplay_game then return end
	end

	on_player_created_straight(event)
end

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
