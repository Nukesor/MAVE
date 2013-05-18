require("core/helper")
require("core/system")

MainMousePressedSystem = class("MainMousePressedSystem")

function MainMousePressedSystem:fireEvent(event)
    if event.button == "r" and not playercutie:getComponent("DashingComponent") then
	    local targetX, targetY = event.x, event.y 
        local xBefore, yBefore = playercutie:getComponent("PhysicsComponent").body:getPosition()
        playercutie:addComponent(DashingComponent({x=xBefore, y=yBefore}, {x=targetX, y=targetY}))
    elseif event.button == "r" and playercutie:getComponent("DashingComponent") then
        playercutie:removeComponent("DashingComponent")
    end
end