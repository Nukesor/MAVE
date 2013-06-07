BoxHoverSystem = class("BoxHoverSystem", System)

function BoxHoverSystem:__init()
	self.__super.__init(self)
	self.lastHover = nil
end

function BoxHoverSystem:update(dt)
	local x, y = love.mouse.getPosition()
	for index, value in pairs(self.targets) do
		if (x >= value:getComponent("PositionComponent").x) and (x <= (value:getComponent("PositionComponent").x + value:getComponent("BoxComponent").width)) then
			if (y >= value:getComponent("PositionComponent").y) and (y <= (value:getComponent("PositionComponent").y + value:getComponent("BoxComponent").height)) then
				value:getComponent("BoxComponent").hover = true
				if (self.lastHover ~= nil) and (self.lastHover ~= value) then
					self.lastHover:getComponent("BoxComponent").hover = false					
					self.lastHover = value
				elseif (self.lastHover == nil) then
					self.lastHover = value
				end
			end
		end
	end
end

function BoxHoverSystem:getRequiredComponents()
	return {"BoxComponent"}
end