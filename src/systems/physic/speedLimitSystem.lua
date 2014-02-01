SpeedLimitSystem = class("SpeedLimitSystem", System)

function SpeedLimitSystem:update()
    for key, entity in pairs(self.targets) do
        local body = entity:getComponent("PhysicsComponent").body
        local xacc, yacc = body:getLinearVelocity()
        -- Sets the Speedlimit for Cuties
        local height = love.graphics.getHeight()
        local width = love.graphics.getWidth()
        if yacc > height * (4/3) then
            body:setLinearVelocity(xacc, height * (4/3))
            yacc = height * (4/3)
        elseif yacc < -height/2 then
            body:setLinearVelocity(xacc, -height/2)
            xacc = -height/2
        end
        if xacc > width/2 then
            body:setLinearVelocity(width/2, yacc)
            xacc = width/2
        elseif xacc < -width/2 then
            body:setLinearVelocity(-width/2, yacc)
            xacc = width/2
        end
    end
end

function SpeedLimitSystem:requires()
    return {"CutieComponent"}
end
