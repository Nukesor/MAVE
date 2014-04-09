TimerShotDeletionSystem = class("TimerShotDeletionSystem", System)

function TimerShotDeletionSystem:update(dt)
    for index, entity in pairs(self.targets) do
        entity:get("TimerComponent").time = entity:get("TimerComponent").time - dt
        if entity:get("TimerComponent").time < 0 then
            entity:add(DestroyComponent())
        end
    end
end


function TimerShotDeletionSystem:requires()
    return {"TimerComponent", "IsShot"}
end