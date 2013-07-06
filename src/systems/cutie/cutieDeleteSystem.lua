CutieDeleteSystem = class("CutieDeleteSystem", System)

function CutieDeleteSystem:update()
    for index, entity in pairs(self.targets) do
        if entity:getComponent("LifeComponent").life <= 0 then
            gameplay.gold = gameplay.gold + entity:getComponent("GoldComponent").gold
            gameplay.kills = gameplay.kills + 1
            DestroyBody(entity)
        end
    end
end

function CutieDeleteSystem:getRequiredComponents()
    return {"IsEnemy"}
end