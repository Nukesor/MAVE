MainMousePressedSystem = class("MainMousePressedSystem")

function MainMousePressedSystem:fireEvent(event)
    if event.button == "r" then
        local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
        if playercutie:get("DashingComponent") then
            playercutie:remove("DashingComponent")
        end
        local targetX, targetY = event.x, event.y 
        local xBefore, yBefore = playercutie:get("PhysicsComponent").body:getPosition()

        -- Adds a DashingComponent to the PlayerCutie
        playercutie:add(DashingComponent({x=xBefore, y=yBefore}, {x=targetX, y=targetY}))
    end
end