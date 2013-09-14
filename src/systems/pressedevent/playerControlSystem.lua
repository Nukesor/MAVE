PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem:fireEvent(event)
    -- Playercutie Jump
    if event.key == "s" or event.key == "down" then
        playercutie:getComponent("PhysicsComponent").body:applyLinearImpulse(0, 1)
    elseif event.key == "w" or event.key == "up" then
        if playercutie:getComponent("IsPlayer").jumpcount > 0 then
            playercutie:getComponent("PhysicsComponent").body:applyLinearImpulse(0, -14)
            playercutie:getComponent("IsPlayer").jumpcount = playercutie:getComponent("IsPlayer").jumpcount - 1
        end
    end
end