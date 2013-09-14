BleedingDetectSystem = class("BleedingDetectSystem", System)

function BleedingDetectSystem:update(dt)
    for index, entity in pairs(self.targets) do
        -- Checks if life is below 1/4 of full health and adds a particleComponent for bleeding animation.
        if (entity:getComponent("LifeComponent").life/entity:getComponent("LifeComponent").maxlife) <= 0.25 then
            if not entity:getComponent("ParticleComponent") then
                entity:addComponent(ParticleComponent(resources.images.blood1, 50, 30, 20, 10, 0.3, 0.2, 
                                                255, 0, 0, 255, 200, 0, 0, 255, 
                                                entity:getComponent("PositionComponent").x, entity:getComponent("PositionComponent").y, -1, 0.4, 0.5, 0, 360, 
                                                0, 0, 50, 100))
                entity:getComponent("ParticleComponent").hit:start()
                stack:current().engine:componentAdded(entity, {"ParticleComponent"})
            end
            entity:getComponent("ParticleComponent").hit:setPosition(entity:getComponent("PositionComponent").x, entity:getComponent("PositionComponent").y)
        end
    end
end

function BleedingDetectSystem:getRequiredComponents()
    return{"CutieComponent", "LifeComponent"}
end