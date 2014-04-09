TimerSystem = class("TimerSystem", System)

function TimerSystem:update(dt)
    for index, value in pairs(self.targets) do
        value:get("TimerComponent").time = value:get("TimerComponent").time - dt
    end
end

function TimerSystem:requires()
    return {"TimerComponent"}
end