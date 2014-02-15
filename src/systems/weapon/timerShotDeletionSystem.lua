TimerShotDeletionSystem = class("TimerShotDeletionSystem", System)

function TimerShotDeletionSystem:update(dt)
    for index, entity in pairs(self.targets) do
        entity:getComponent("TimerComponent").time = entity:getComponent("TimerComponent").time - dt
        if entity:getComponent("TimerComponent").time < 0 then
            entity:addComponent(DestroyComponent())
        end
    end
end


function TimerShotDeletionSystem:requires()
    return {"TimerComponent", "IsShot"}
end