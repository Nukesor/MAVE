DashingSystem = class("DashingSystem", System)

function DashingSystem:update(dt)
    for key, entity in pairs(self.targets) do
        -- Calculate normalized target position
        local targetX = entity:get("DashingComponent").targetPosition.x
        local targetY = entity:get("DashingComponent").targetPosition.y
        local physics = entity:get("PhysicsComponent")
        local playerX = entity:get("DashingComponent").startPosition.x
        local playerY = entity:get("DashingComponent").startPosition.y

        targetX = targetX - playerX
        targetY = targetY - playerY
        local length = math.sqrt(targetX*targetX+targetY*targetY)/(love.graphics.getWidth()*1.5)
        targetX = targetX/length
        targetY = targetY/length

        -- Set Velocity according to calculated position
        physics.body:setLinearVelocity(targetX, targetY)

        -- update timer. if dashed for long enough, remove the component
        entity:get("DashingComponent").time = entity:get("DashingComponent").time + dt
        if entity:get("DashingComponent").time >= 0.15 then
            entity:remove("DashingComponent")
        end
    end
end

function DashingSystem:requires()
    return {"PhysicsComponent", "DashingComponent"}
end