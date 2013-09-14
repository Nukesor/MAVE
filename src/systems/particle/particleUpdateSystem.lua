ParticleUpdateSystem = class("ParticleUpdateSystem", System)

function ParticleUpdateSystem:update(dt)
    for index, entity in pairs(self.targets) do
        -- Updates Particles. If timer is below 0 the entity will be removed
        entity.components.ParticleComponent.hit:update(dt)
        if entity:getComponent("TimeComponent") then
            entity.components.TimeComponent.timer = entity.components.TimeComponent.timer - dt
            if entity.components.TimeComponent.timer < 0 then
                stack:current().engine:removeEntity(entity)
            end
        end
    end
end

function ParticleUpdateSystem:getRequiredComponents(dt)
    return {"ParticleComponent"}
end