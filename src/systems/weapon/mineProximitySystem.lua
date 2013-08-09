MineProximitySystem = class("MineProximitySystem", System)

function MineProximitySystem:__init()	end

function MineProximitySystem:update(dt)
	--print(#self.targets)
	for index, entity in pairs(self.targets) do
		for index2, enemy in pairs(stack:current().engine:getEntitylist("IsEnemy")) do
			if distanceBetweenEntities(entity, enemy) <= entity:getComponent("ExplosionComponent").radius then
				stack:current().engine:fireEvent(ExplosionEvent(entity))
				break
			end
		end
	end
end

function MineProximitySystem:getRequiredComponents()
	return {"IsMine"}
end