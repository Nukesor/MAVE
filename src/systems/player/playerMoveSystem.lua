PlayerMoveSystem = class("PlayerMoveSystem", System)

function PlayerMoveSystem:update(dt)
    -- Cutienavigation left right
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        playercutie:getComponent("PhysicsComponent").body:applyLinearImpulse(love.graphics.getHeight()/1000, 0)
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        playercutie:getComponent("PhysicsComponent").body:applyLinearImpulse(-love.graphics.getHeight()/1000, 0)
    end
end

function PlayerMoveSystem:getRequiredComponents()
    return {}
end
