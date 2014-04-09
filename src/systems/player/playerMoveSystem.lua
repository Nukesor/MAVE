PlayerMoveSystem = class("PlayerMoveSystem", System)

function PlayerMoveSystem:update(dt)
    -- Cutienavigation left right
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
        playercutie:get("PhysicsComponent").body:applyLinearImpulse(love.graphics.getHeight()/20 *dt, 0)
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
        playercutie:get("PhysicsComponent").body:applyLinearImpulse(-love.graphics.getHeight()/20 *dt, 0)
    end
end

function PlayerMoveSystem:requires()
    return {}
end
