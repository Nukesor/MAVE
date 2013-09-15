TimerSystem = class("TimerSystem", System)

function TimerSystem:update(dt)
    for index, value in pairs(self.targets) do
        value:getComponent("TimerComponent").time = value:getComponent("TimerComponent").time - dt
    end
end

function TimerSystem:getRequiredComponents()
    return {"TimerComponent"}
end