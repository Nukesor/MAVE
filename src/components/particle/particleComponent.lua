local ParticleComponent = Component.create("ParticleComponent")

function ParticleComponent:initialize(image, buffer)
    self.particle = love.graphics.newParticleSystem(image, buffer)
end

return ParticleComponent
