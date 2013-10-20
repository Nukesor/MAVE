TimerExplosionSystem = class("TimerExplosionSystem", System)

-- Lets explodable things with a timer explode.
function TimerExplosionSystem:update(dt)
    for index, value in pairs(self.targets) do
        if value.components.TimerComponent.time < 0 then
            stack:current().eventmanager:fireEvent(ExplosionEvent(value))
        end
    end
end

function TimerExplosionSystem:getRequiredComponents()
    return {"TimerComponent", "ExplosionComponent"}
end