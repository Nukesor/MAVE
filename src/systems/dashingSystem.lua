DashingSystem = class("DashingSystem", System)

function DashingSystem:update(dt)
    for key, entity in pairs(self.targets) do
        local targetX = entity:getComponent("Dashing").targetPosition.x
        local targetY = entity:getComponent("Dashing").targetPosition.y
        local physics = entity:getComponent("Physics")
        local playerX = physics.body:getX()
        local playerY = physics.body:getY()

        targetX = targetX - playerX
        targetY = targetY - playerY
        local length = math.sqrt(targetX*targetX, targetY*targetY)/1000
        targetX = targetX/length
        targetY = targetY/length

        physics.body:setLinearVelocity(targetX, targetY)
        entity:getComponent("Dashing").time = entity:getComponent("Dashing").time + dt
        if entity:getComponent("Dashing").time >= 0.5 then
            physics.body:setLinearVelocity(entity:getComponent("Dashing").xVelocityBefore, entity:getComponent("Dashing").yVelocityBefore)
            entity:removeComponent("Dashing")
        end
    end
end

function DashingSystem:getRequiredComponents()
    return {"isPlayer", "Physics", "Dashing"}
end