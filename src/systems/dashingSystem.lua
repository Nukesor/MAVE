DashingSystem = class("DashingSystem", System)

function DashingSystem:update(dt)
    for key, entity in pairs(self.targets) do
        local targetX = entity:getComponent("DashingComponent").targetPosition.x
        local targetY = entity:getComponent("DashingComponent").targetPosition.y
        local physics = entity:getComponent("PhysicsComponent")
        local playerX = entity:getComponent("DashingComponent").startPosition.x
        local playerY = entity:getComponent("DashingComponent").startPosition.y

        targetX = targetX - playerX
        targetY = targetY - playerY
        local length = math.sqrt(targetX*targetX+targetY*targetY)/1500
        targetX = targetX/length
        targetY = targetY/length

        physics.body:setLinearVelocity(targetX, targetY)
        entity:getComponent("DashingComponent").time = entity:getComponent("DashingComponent").time + dt
        if entity:getComponent("DashingComponent").time >= 0.3 then
            entity:removeComponent("DashingComponent")
        end
    end
end

function DashingSystem:getRequiredComponents()
    return {"IsPlayer", "PhysicsComponent", "DashingComponent"}
end