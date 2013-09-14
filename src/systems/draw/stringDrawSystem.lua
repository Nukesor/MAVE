StringDrawSystem = class("StringDrawSystem", System)

function StringDrawSystem:draw()
	for index, entity in pairs(self.targets) do
		love.graphics.setFont(entity:getComponent("StringComponent").font)
		local position = entity:getComponent("PositionComponent")
	    love.graphics.print(string.format(entity:getComponent("StringComponent").string, unpack(entity:getComponent("Stringcomponent").values)), position.x, position.y)
	end
end

function StringDrawSystem:getRequiredComponents()
	return {"PositionComponent", "StringComponent"}
end