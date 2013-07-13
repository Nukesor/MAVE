BoxHoverSystem = class("BoxHoverSystem", System)

function BoxHoverSystem:__init()
	self.x = 0
	self.y = 0
end

function BoxHoverSystem:update(dt)
	local x, y = love.mouse.getPosition()
	if self.x ~= x or self.y ~= y then
		self.x = x
		self.y = y
		for index, value in pairs(self.targets) do
			--Prueft, ob der der Mauszeiger ueber irgendeiner Box ist und setzt diese gegebenenfalls auf selected.
			if (x >= value:getComponent("PositionComponent").x) and (x <= (value:getComponent("PositionComponent").x + value:getComponent("BoxComponent").width)) then
				if (y >= value:getComponent("PositionComponent").y) and (y <= (value:getComponent("PositionComponent").y + value:getComponent("BoxComponent").height)) then
					getSelectedBox():getComponent("BoxComponent").selected = false
					value:getComponent("BoxComponent").selected = true
				end
			end
		end
	end
end

function BoxHoverSystem:getRequiredComponents()
	return {"BoxComponent"}
end
