MaxSpeedSystem = class("MaxSpeedSystem", System)

function MaxSpeedSystem:update()
    for key, entity in pairs(self.targets) do
        local body = entity:getComponent("PhysicsComponent").body
        local xacc, yacc = body:getLinearVelocity()

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

function MaxSpeedSystem:getRequiredComponents()
    return {"PhysicsComponent", "CutieComponent"}
end