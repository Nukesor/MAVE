require("core/helper")
require("core/system")

MainMousePressedSystem = class("MainMousePressedSystem")

function MainMousePressedSystem:fireEvent(event)
    if event.button == "r" and not playercutie:getComponent("DashingComponent") then
	    local x, y = playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y
        local xBefore, yBefore = playercutie:getComponent("PhysicsComponent").body:getPosition()
        playercutie:addComponent(DashingComponent({x=xBefore, y=yBefore}, {x=x, y=y}))
    elseif event.button == "r" and playercutie:getComponent("DashingComponent") then
        playercutie:removeComponent("DashingComponent")
    end
end