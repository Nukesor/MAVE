require("core/class")
require("core/system")

MainMousePressedSystem = class("MainMousePressedSystem")

function MainMousePressedSystem:fireEvent(event)
    if event.button == "r" then
        if playercutie:getComponent("DashingComponent") then
            playercutie:removeComponent("DashingComponent")
        end
        local targetX, targetY = event.x, event.y 
        local xBefore, yBefore = playercutie:getComponent("PhysicsComponent").body:getPosition()
        playercutie:addComponent(DashingComponent({x=xBefore, y=yBefore}, {x=targetX, y=targetY}))
    end
end