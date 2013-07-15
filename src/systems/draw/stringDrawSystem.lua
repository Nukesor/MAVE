StringDrawSystem = class("StringDrawSystem", System)

function StringDrawSystem:draw()
	for index, value in pairs(self.targets) do
		love.graphics.setFont(value:getComponent("StringComponent").font)
		local position = value:getComponent("PositionComponent")
	    love.graphics.print(string.format(unpack(value:getComponent("StringComponent").string)), position.x, position.y)
	end
end

function StringDrawSystem:getRequiredComponents()
	return {"PositionComponent", "StringComponent"}
end