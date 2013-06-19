require("core/class")
require("core/system")

PlayerMoveSystem = class("PlayerMoveSystem", System)

function PlayerMoveSystem:update(dt)
    -- Cutienavigation left right
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        playercutie:getComponent("PhysicsComponent").body:applyLinearImpulse(0.5, 0)
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        playercutie:getComponent("PhysicsComponent").body:applyLinearImpulse(-0.5, 0)
    end
end

function PlayerMoveSystem:getRequiredComponents()
    return {}
end