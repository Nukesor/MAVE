DashingSystem = class("DashingSystem", System)

function DashingSystem:update(dt)
    for key, entity in pairs(self.targets) do
        -- Calculate normalized target position
        local targetX = entity:getComponent("DashingComponent").targetPosition.x
        local targetY = entity:getComponent("DashingComponent").targetPosition.y
        local physics = entity:getComponent("PhysicsComponent")
        local playerX = entity:getComponent("DashingComponent").startPosition.x
        local playerY = entity:getComponent("DashingComponent").startPosition.y

        targetX = targetX - playerX
        targetY = targetY - playerY
        local length = math.sqrt(targetX*targetX+targetY*targetY)/(love.graphics.getWidth()*1.5)
        targetX = targetX/length
        targetY = targetY/length

        -- Set Velocity according to calculated position
        physics.body:setLinearVelocity(targetX, targetY)

        -- update timer. if dashed for long enough, remove the component
        entity:getComponent("DashingComponent").time = entity:getComponent("DashingComponent").time + dt
        if entity:getComponent("DashingComponent").time >= 0.15 then
            entity:removeComponent("DashingComponent")
            stack:current().engine:componentRemoved(entity, {"DashingComponent"})
        end
    end
end

function DashingSystem:getRequiredComponents()
    return {"PhysicsComponent", "DashingComponent"}
end