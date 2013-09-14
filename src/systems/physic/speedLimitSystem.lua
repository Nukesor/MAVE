SpeedLimitSystem = class("SpeedLimitSystem", System)

function SpeedLimitSystem:update()
    for key, entity in pairs(self.targets) do
        local body = entity:getComponent("PhysicsComponent").body
        local xacc, yacc = body:getLinearVelocity()
        -- Sets the Speedlimit for Cuties
        if yacc > 800 then
            body:setLinearVelocity(xacc, 800)
            yacc = 800
        elseif yacc < -300 then
            body:setLinearVelocity(xacc, -300)
            yacc = -300
        end
        if xacc > 500 then
            body:setLinearVelocity(500, yacc)
            xacc = 500
        elseif xacc < -500 then
            body:setLinearVelocity(-500, yacc)
            xacc = 500
        end
    end
end

function SpeedLimitSystem:getRequiredComponents()
    return {"CutieComponent"}
end
