-- Synchronizes the Position Component with the Position of the Body Component, if an Entity has both.
PhysicsPositionSyncSystem = class("PhysicsPositionSyncSystem", System)

function PhysicsPositionSyncSystem:update(dt)
    for k, entity in pairs(self.targets) do
        entity:getComponent("Position").x = entity:getComponent("Physics").body:getX()
        entity:getComponent("Position").y = entity:getComponent("Physics").body:getY()
    end
end

function PhysicsPositionSyncSystem:getRequiredComponents()
    return {"Physics", "Position"}
end