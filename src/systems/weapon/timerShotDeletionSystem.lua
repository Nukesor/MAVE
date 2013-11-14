TimerShotDeletionSystem = class("TimerShotDeletionSystem", System)

function TimerShotDeletionSystem:update(dt)
    for index, entity in pairs(self.targets) do
        entity:getComponent("TimerComponent").time = entity:getComponent("TimerComponent").time - dt
        if entity:getComponent("TimerComponent").time < 0 then
            entity:addComponent(DestroyComponent())
            stack:current().engine:componentAdded(entity, {"DestroyComponent"})
        end
    end
end


function TimerShotDeletionSystem:getRequiredComponents()
    return {"TimerComponent", "IsShot"}
end