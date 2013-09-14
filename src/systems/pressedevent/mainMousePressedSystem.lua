MainMousePressedSystem = class("MainMousePressedSystem")

function MainMousePressedSystem:fireEvent(event)
    if event.button == "r" then
        if playercutie:getComponent("DashingComponent") then
            playercutie:removeComponent("DashingComponent")
        end
        local targetX, targetY = event.x, event.y 
        local xBefore, yBefore = playercutie:getComponent("PhysicsComponent").body:getPosition()

        -- Adds a DashingComponent to the PlayerCutie
        playercutie:addComponent(DashingComponent({x=xBefore, y=yBefore}, {x=targetX, y=targetY}))
        stack:current().engine:componentAdded(entity, {"DashingComponent"})
    end
    if event.button == "l" then
        -- Calls the funktion of the equiped item.
    	if playercutie:getComponent("ItemComponent") then
    		playercutie:getComponent("ItemComponent").use()
    	end
    end
end