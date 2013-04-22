require("core/helper")
require("core/system")

SpeedLimitSystem = class("SpeedLimitSystem", System)

function SpeedLimitSystem:update(dt)
	for index, entity in pairs(self.targets) do
    	local xacc, yacc =  entity:getComponent("PhysicsComponent").body:getLinearVelocity()
		-- Geschwindigkeitsbegrenzung für Cuties
        if yacc > 800 then
            entity:getComponent("PhysicsComponent").body:setLinearVelocity(xacc, 800)
            yacc = 800
        elseif yacc < -300 then
            entity:getComponent("PhysicsComponent").body:setLinearVelocity(xacc, -300)
            yacc = -300
        end
        if xacc > 500 then
            entity:getComponent("PhysicsComponent").body:setLinearVelocity(500, yacc)
            xacc = 500
        elseif xacc < -500 then
            entity:getComponent("PhysicsComponent").body:setLinearVelocity(-500, yacc)
            xacc = 500
        end
	end
end

function SpeedLimitSystem:getRequiredComponents()
	return{"CutieComponent"}
end