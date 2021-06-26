
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

	local items = {}

	if hours >= 1 then
		join(items, {
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
			{"firearm-magazine", 20},
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
			{"repair-pack", 10},
			{"stone-wall", 60},
		})
		if hours == 1 then
			items[#items+1] = {"shotgun", 1}
			items[#items+1] = {"light-armor", 1}
		end
	end

	if hours >= 2 then
		join(items, {
			{"medium-electric-pole", 5},
			{"grenade", 10},
			{"piercing-rounds-magazine", 10},
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
			{"slowdown-capsule", 5},
			{"poison-capsule", 5},
			{"engine-unit", 6},
			{"substation", 6},
		})
		items[#items+1] = {"submachine-gun", 1}
		items[#items+1] = {"combat-shotgun", 1}
		items[#items+1] = {"rocket-launcher", 1}
		items[#items+1] = {"car", 1}
		if hours == 2 then
			items[#items+1] = {"stone-brick", 1000}
			items[#items+1] = {"heavy-armor", 1}
		end
	else
		return items
	end

	if hours >= 5 then
		join(items, {
			{"big-electric-pole", 5},
			{"pumpjack", 3},
			{"concrete", 1000},
			{"advanced-circuit", 10},
			{"land-mine", 10},
			{"cluster-grenade", 10},
			{"flamethrower-ammo", 10},
			{"rocket-fuel", 5},
			{"assembling-machine-2", 8},
			{"oil-refinery", 1},
			{"chemical-plant", 5},
			{"steel-furnace", 10},
			{"storage-tank", 3},
		})
		items[#items+1] = {"flamethrower", 1}
		if hours == 5 then
			items[#items+1] = {"modular-armor", 1}
		end
	else
		return items
	end

	if hours >= 8 then
		join(items, {
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
		items[#items+1] = {"tank", 1}
		items[#items+1] = {"night-vision-equipment", 1}
		if hours == 8 then
			items[#items+1] = {"fusion-reactor-equipment", 1}
			items[#items+1] = {"power-armor", 1}
		end
	else
		return items
	end

	if hours >= 10 then
		join(items, {
			{"nuclear-fuel", 1},
			{"uranium-rounds-magazine", 15},
		})
		items[#items+1] = {"spidertron", 1}
		items[#items+1] = {"exoskeleton-equipment", 1}
		items[#items+1] = {"personal-roboport-equipment", 1}
		if hours == 10 then
			items[#items+1] = {"fusion-reactor-equipment", 2}
			items[#items+1] = {"power-armor-mk2", 1}
		end
	else
		return items
	end

	return items
end
start_items = get_start_items()

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

	for _, item in pairs(start_items) do
		if game.item_prototypes[item[1]] then
			local items = {name = item[1], count = item[2]}
			if target.can_insert(items) then
				target.insert(items) -- TODO: check inserted count of items
			else
				container_name = find_chest() -- this is dirty
				position = surface.find_non_colliding_position(container_name, position, 30, 1)
				if position == nil then
					log("Can't find non colliding position for " .. container_name)
					return
				end
				target = surface.create_entity{name = container_name, position = position, force = neutral_force, create_build_effect_smoke = false}
			end
		else
			log("\""..item[1].."\" doesn't exist in the game, please check spelling.")
		end
	end
end

local function on_player_created_straight(event)
	local target = game.get_player(event.player_index)
	if not (target and target.valid) then return end

	local position = target.position
	local neutral_force = game.forces["neutral"]
	local surface = target.surface
	for _, item in pairs(start_items) do
		if game.item_prototypes[item[1]] then
			local items = {name = item[1], count = item[2]}
			if target.can_insert(items) then
				target.insert(items) -- TODO: check inserted count of items
			else
				container_name = find_chest() -- this is dirty
				position = surface.find_non_colliding_position(container_name, position, 30, 1)
				if position == nil then
					log("Can't find non colliding position for " .. container_name)
					return
				end
				target = surface.create_entity{name = container_name, position = position, force = neutral_force, create_build_effect_smoke = false}
			end
		end
	end
end

---@param event table
local function on_freeplayer_created(event)
	if hours == 0 then return end
	if global.is_freeplay_game then return end
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
		start_items = get_start_items()
	elseif setting_name == "sh-hours" then
		hours = settings.global[setting_name].value
		start_items = get_start_items()
	end
end


script.on_event(defines.events.on_runtime_mod_setting_changed, on_runtime_mod_setting_changed)

if script.level.level_name == "freeplay" then
	script.on_event(defines.events.on_player_created, on_freeplayer_created)
else
	script.on_event(defines.events.on_player_created, function(event)
		if hours == 0 then return end
		on_player_created_straight(event)
	end)
end
