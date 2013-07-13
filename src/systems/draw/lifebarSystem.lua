LifebarSystem = class("LifebarSystem", System)

function LifebarSystem:draw()
	for index, value in pairs(self.targets) do
		local position = value:getComponent("PositionComponent")
		local life = value:getComponent("LifeComponent")
		love.graphics.setColor(255, 0, 0, 150)
		love.graphics.rectangle("fill", position.x-8, position.y-20, 20, 4)
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.rectangle("fill", position.x-8, position.y-20, 20*(life.life/life.maxlife), 4)
	end
end


function LifebarSystem:getRequiredComponents()
	return {"LifeComponent"}
end