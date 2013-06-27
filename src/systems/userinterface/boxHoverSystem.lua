BoxHoverSystem = class("BoxHoverSystem", System)

function BoxHoverSystem:__init()
	
end

function BoxHoverSystem:update(dt)
	local x, y = love.mouse.getPosition()
	for index, value in pairs(self.targets) do
		--Prueft, ob der der Mauszeiger ueber irgendeiner Box ist und setzt diese gegebenenfalls auf selected.
		if (x >= value:getComponent("PositionComponent").x) and (x <= (value:getComponent("PositionComponent").x + value:getComponent("BoxComponent").width)) then
			if (y >= value:getComponent("PositionComponent").y) and (y <= (value:getComponent("PositionComponent").y + value:getComponent("BoxComponent").height)) then
				self:getSelectedBox():getComponent("BoxComponent").selected = false
				value:getComponent("BoxComponent").selected = true
			end
		end
	end
end

function BoxHoverSystem:getRequiredComponents()
	return {"BoxComponent"}
end

-- Holt sich die momentan selektierte Box
function BoxHoverSystem:getSelectedBox()
	for index, value in pairs(self.targets) do
		if value:getComponent("BoxComponent").selected == true then 
			return value
		end
	end
end