CutieDeleteSystem = class("CutieDeleteSystem", System)

function CutieDeleteSystem:update()
    for index, entity in pairs(self.targets) do
        -- If EnemyCuties health falls below 0 it gets deleted. Blood is added to gameplay.blood
        if entity:getComponent("LifeComponent").life <= 0 then
            gameplay.stats["blood"] = gameplay.stats["blood"] + entity:getComponent("BloodComponent").blood
            gameplay.stats["kills"] = gameplay.stats["kills"] + 1

            local bloodup = Entity()
            bloodup:addComponent(BloodUpComponent(entity:getComponent("BloodComponent").blood))
            bloodup:addComponent(PositionComponent(entity:getComponent("PositionComponent").x, entity:getComponent("PositionComponent").y))
            bloodup:addComponent(TimerComponent(1.5))
            stack:current().engine:addEntity(bloodup)

            entity:addComponent(DestroyComponent())
        end
    end
end

function CutieDeleteSystem:requires()
    return {"IsEnemy"}
end