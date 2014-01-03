BodyDestroySystem = class("BodyDestroySystem", System)

function BodyDestroySystem:update()
    for index, entity in pairs(self.targets) do
        if entity:getComponent("ParticleComponent") then
            local particle = Entity()
            particle:addComponent(ParticleTimerComponent(0.6, 2))
            particle:addComponent(entity:getComponent("ParticleComponent"))
            particle:getComponent("ParticleComponent").particle:start()
            stack:current().engine:addEntity(particle)
        end
        removeEntityWithPhysics(entity)
      end
end

function BodyDestroySystem:getRequiredComponents()
      return {"DestroyComponent"}
end