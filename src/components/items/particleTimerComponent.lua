ParticleTimerComponent = class("ParticleTimerComponent", Component)

function ParticleTimerComponent:__init(lifetime, maxparttime)
    self.timer = lifetime + maxparttime + 0.2
end