ParticleDrawSystem = class("ParticleDrawSystem", System)

function ParticleDrawSystem:draw()
    for index, particle in pairs(self.targets) do
        love.graphics.draw(particle.components.ParticleComponent.hit, 0, 0)
        love.graphics.draw(particle.components.ParticleComponent.hit, -love.graphics.getWidth(), 0)
        love.graphics.draw(particle.components.ParticleComponent.hit, love.graphics.getWidth(), 0)
    end
end

function ParticleDrawSystem:getRequiredComponents()
    return {"ParticleComponent"}
end