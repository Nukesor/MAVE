require("core/helper")
require("core/system")

ExplosionSystem = class("ExplosionSystem", System)

function ExplosionSystem:__init()
	for index, value in pairs(self.targets) do
		for i, v in pairs(engine.entities) do 
			if v.getComponent("IsEnemy") then
				local exp = value:getComponent("ExplosionComponent")
				local enemypos = v:getComponent("PositionComponent")
				if (math.sqrt((enemypos.x-exp.x)^2 + (enemypos.y-exp.y)^2)) < exp.radius then
					v.components.LifeComponent.life = v.components.LifeComponent.life - exp.damage
				end
			end
		end
		engine:removeEntity(value)
	end
end


function ExplosionSystem:getRequiredComponents()
	return {"ExplosionComponent"}
end