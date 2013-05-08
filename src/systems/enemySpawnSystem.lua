require("core/helper")
require("core/system")

EnemySpawnSystem = class("EnemySpawnSystem", System)


function EnemySpawnSystem:update(dt)
	if fire == true then
			local height = math.random(300, 500)
			local cutie
			cutie = CutieModel(0, height, resources.images.cutie2)
		    cutie:addComponent(IsEnemy())
		    cutie:addComponent(EnemyComponent())
		    engine:addEntity(cutie)
	end
end

function EnemySpawnSystem:getRequiredComponents()
	return {}
end