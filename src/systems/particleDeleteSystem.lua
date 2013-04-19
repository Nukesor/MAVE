require("core/helper")
require("core/system")

ParticleDeleteSystem = class("ParticleDeleteSystem", System)

function ParticleDeleteSystem:update(dt)
	for index, particle in pairs(self.targets) do
		particle.components.ParticleComponent.timer = particle.components.ParticleComponent.timer - dt
		particle.components.ParticleComponent.hit:update(dt)
		if particle.components.ParticleComponent.timer < 0 then
			engine:removeEntity(particle)
		end
	end
end

function ParticleDeleteSystem:getRequiredComponents(dt)
	return {"ParticleComponent"}
end