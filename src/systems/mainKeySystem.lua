
require("core/helper")
require("core/system")

MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:fireEvent(event)
	-- Playercutie Jump
    if event.key == "i" then
        playercutie:getComponent("LifeComponent").life = 10
    elseif event.key == "u" then
        playercutie:getComponent("LifeComponent").life = 0
    elseif event.key == "o" then
        cutie:getComponent("LifeComponent").life = 0
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
    end
end