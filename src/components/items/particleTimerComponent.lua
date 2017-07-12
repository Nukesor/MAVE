local ParticleTimerComponent = Component.create("ParticleTimerComponent")

function ParticleTimerComponent:initialize(lifetime, maxparttime)
    self.timer = lifetime + maxparttime + 0.2
end

return ParticleTimerComponent
