
local ship = data.raw.container["crash-site-spaceship"]
if ship and ship.inventory_size < 50 then
	ship.inventory_size = 50
end
