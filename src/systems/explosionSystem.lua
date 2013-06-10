require("core/helper")
require("core/system")

ExplosionSystem = class("ExplosionSystem")

function ExplosionSystem:fireEvent(event)
	local entity = event.entity
	for i, v in pairs(engine.IsEnemy) do 
		local exp = entity:getComponent("PositionComponent")
		local enemypos = v:getComponent("PositionComponent")
		if (math.sqrt((enemypos.x-exp.x)^2 + (enemypos.y-exp.y)^2)) < entity:getComponent("ExplosionComponent").radius then
			v:getComponent("LifeComponent").life = v:getComponent("LifeComponent").life - entity:getComponent("ExplosionComponent").damage
		end
	end
	engine:removeEntity(entity)
end