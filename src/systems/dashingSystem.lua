DashingSystem = class("DashingSystem", System)

function DashingSystem:update(dt)
    for key, entity in pairs(self.targets) do
        local targetX = entity:getComponent("Dashing").targetPosition.x
        local targetY = entity:getComponent("Dashing").targetPosition.y
        local physics = entity:getComponent("Physics")
        local playerX = entity:getComponent("Dashing").startPosition.x
        local playerY = entity:getComponent("Dashing").startPosition.y

        targetX = targetX - playerX
        targetY = targetY - playerY
        local length = math.sqrt(targetX*targetX, targetY*targetY)/1000
        targetX = targetX/length
        targetY = targetY/length

        physics.body:setLinearVelocity(targetX, targetY)
        entity:getComponent("Dashing").time = entity:getComponent("Dashing").time + dt
        if entity:getComponent("Dashing").time >= 0.5 then
            physics.body:setLinearVelocity(entity:getComponent("Dashing").startVelocity.x, entity:getComponent("Dashing").startVelocity.y)
            entity:removeComponent("Dashing")
        end
    end
end

function DashingSystem:getRequiredComponents()
    return {"isPlayer", "Physics", "Dashing"}
end