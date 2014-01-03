BodyDestroySystem = class("BodyDestroySystem", System)

function BodyDestroySystem:update()
    for index, entity in pairs(self.targets) do
        if entity:getComponent("ParticleComponent") then
            local particle = Entity()
            particle:addComponent(entity:getComponent("ParticleComponent"))
            particle:getComponent("ParticleComponent").particle:pause()
            local min, max = particle:getComponent("ParticleComponent").particle:getParticleLifetime()
            local life = particle:getComponent("ParticleComponent").particle:getEmitterLifetime()
            if life == -1 then
                life = 0
            end
            particle:addComponent(ParticleTimerComponent(life, max))
            stack:current().engine:addEntity(particle)
        end
        removeEntityWithPhysics(entity)
      end
end

function BodyDestroySystem:getRequiredComponents()
      return {"DestroyComponent"}
end