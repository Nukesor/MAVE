CutieDeleteSystem = class("CutieDeleteSystem", System)

function CutieDeleteSystem:update()
    for index, entity in pairs(self.targets) do
    	-- If EnemyCuties health falls below 0 it gets deleted. Gold is added to gameplay.gold
        if entity:getComponent("LifeComponent").life <= 0 then
            gameplay.gold = gameplay.gold + entity:getComponent("GoldComponent").gold
            gameplay.kills = gameplay.kills + 1
            removeEntityWithPhysics(entity)
        end
    end
end

function CutieDeleteSystem:getRequiredComponents()
    return {"IsEnemy"}
end