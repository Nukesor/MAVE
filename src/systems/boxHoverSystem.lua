BoxHoverSystem = class("BoxHoverSystem", System)

function BoxComponent:__init()
	self.super.__init(self)
	self.lastHover = nils
end

function BoxHoverSystem:update(dt)
	local x, y = love.mouse.Position()
	for index, value in pairs(self.targets) do
		if (x >= value:getComponent("PositionComponent").x) and (x <= (value:getComponent("PositionComponent").x + value:getComponent("BoxComponent").length)) then
			if (y >= value:getComponent("PositionComponent").y) and (y <= (value:getComponent("PositionComponent").y + value:getComponent("BoxComponent").height)) then
				value:getComponent("BoxComponent").hover = true
				if (self.lastHover not nil) and (self.lastHover not value) then
					self.lastHover:getComponent('BoxComponent').hover = false					
					self.lastHover = value
				else if (self.lastHover == nil)
					self.lastHover = value
				end
			end
		end	
	end
end

function BoxHoverSystem:getRequiredComponent()
	return {"BoxComponent"}
end