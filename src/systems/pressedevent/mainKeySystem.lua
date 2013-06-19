MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:fireEvent(event)
    -- Playercutie Jump
    if event.key == "o" then
        playercutie:getComponent("LifeComponent").life = 0
    elseif event.key == "p" then
        local canvas = love.graphics.newScreenshot()
        screenshot = love.graphics.newImage(canvas)
        stack:push(pause)
    elseif event.key == "b" then
        main.shaketimer = 0.5
    elseif event.key == "y" then
        engine:removeEntity(playercutie)
    end
    if event.key == "x" then
        local shot = ShotModel(playercutie:getComponent("PositionComponent").x, (playercutie:getComponent("PositionComponent").y - 20), love.mouse.getPosition())
        shot:getComponent("PhysicsComponent").fixture:setUserData(shot)
        engine:addEntity(shot)
    elseif event.key == "g" then
        local grenade = GrenadeModel(playercutie:getComponent("PositionComponent").x, (playercutie:getComponent("PositionComponent").y - 20), love.mouse.getPosition())
        grenade:getComponent("PhysicsComponent").fixture:setUserData(grenade)
        engine:addEntity(grenade)
    end
end