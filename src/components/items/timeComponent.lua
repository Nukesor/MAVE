TimeComponent = class("TimeComponent", Component)

function TimeComponent:__init(lifetime, maxparttime)
    self.timer = lifetime + maxparttime + 0.2
end