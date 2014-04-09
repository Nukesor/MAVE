PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem.fireEvent(self, event)
    -- Playercutie Jump
    if event.key == "s" or event.key == "down" then
        local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
        playercutie:get("PhysicsComponent").body:applyLinearImpulse(0, 1)
    elseif event.key == "w" or event.key == "up" then
        local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
        if playercutie:get("IsPlayer").jumpcount > 0 then
            playercutie:get("PhysicsComponent").body:applyLinearImpulse(0, -9)
            playercutie:get("IsPlayer").jumpcount = playercutie:get("IsPlayer").jumpcount - 1
        end
    end
end
