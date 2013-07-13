ParticleDeleteSystem = class("ParticleDeleteSystem", System)

function ParticleDeleteSystem:update(dt)
    for index, entity in pairs(self.targets) do
        entity.components.ParticleComponent.hit:update(dt)
        if entity:getComponent("TimeComponent") then
            entity.components.TimeComponent.timer = entity.components.TimeComponent.timer - dt
            if entity.components.TimeComponent.timer < 0 then
                stack:current().engine:removeEntity(entity)
            end
        end
    end
end

function ParticleDeleteSystem:getRequiredComponents(dt)
    return {"ParticleComponent"}
end