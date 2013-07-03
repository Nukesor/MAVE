ItemDrawSystem = class("ItemDrawSystem", System)

function ItemDrawSystem:update(dt)
	for index, player in pairs(self.targets) do
		if player:getComponent("ItemComponent").item then
			local item = player:getComponent("ItemComponent").item
        	love.graphics.draw(item.image, pos.x, pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
    	end
	end
end


function ItemDrawSystem:getRequiredComponents()
	return {"IsPlayer"}
end