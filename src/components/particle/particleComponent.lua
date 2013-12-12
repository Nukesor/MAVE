ParticleComponent = class("ParticleComponent")

function ParticleComponent:__init(image, maxparticles)
    self.particle = love.graphics.newParticleSystem(image, maxparticles)
end