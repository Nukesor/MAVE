CutieDeleteSystem = class("CutieDeleteSystem", System)

function CutieDeleteSystem:update()
    for index, entity in pairs(self.targets) do
        -- If EnemyCuties health falls below 0 it gets deleted. Gold is added to gameplay.gold
        if entity:getComponent("LifeComponent").life <= 0 then
            gameplay.stats["gold"] = gameplay.stats["gold"] + entity:getComponent("GoldComponent").gold
            gameplay.stats["kills"] = gameplay.stats["kills"] + 1

            local goldup = Entity()
            goldup:addComponent(GoldUpComponent(entity:getComponent("GoldComponent").gold))
            goldup:addComponent(PositionComponent(entity:getComponent("PositionComponent").x, entity:getComponent("PositionComponent").y))
            goldup:addComponent(TimerComponent(0.5))
            stack:current().engine:addEntity(goldup)

            entity:addComponent(DestroyComponent())
            stack:current().engine:componentAdded(entity, {"DestroyComponent"})
        end
    end
end

function CutieDeleteSystem:getRequiredComponents()
    return {"IsEnemy"}
end