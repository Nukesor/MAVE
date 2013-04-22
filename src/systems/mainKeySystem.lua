
require("core/helper")
require("core/system")

MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:fireEvent(event)
	-- Playercutie Jump
    if event.key == "i" then
        playercutie:getComponent("Life").life = 20
    elseif event.key == "p" then
        local canvas = love.graphics.newScreenshot()
        screenshot = love.graphics.newImage(canvas)
        stack:push(pause)
    elseif event.key == "b" then
        main.shaketimer = 0.5
    elseif event.key == "y" then
        engine:removeEntity(playercutie)
    elseif event.key == "x" then
        local shot = ShotModel(playercutie:getComponent("PositionComponent").x, (playercutie:getComponent("PositionComponent").y + 50), love.mouse.getPosition())
        shot:getComponent("PhysicsComponent").fixture:setUserData(shot)
        engine:addEntity(shot)
    end
end