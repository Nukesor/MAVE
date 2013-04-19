require("core/helper")
require("core/system")

MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:fireEvent(event)
	-- Playercutie Jump
    if event.key == "i" then
        playercutie:getComponent("Life").life = 0
    elseif event.key == "p" then
    	stack:push(pause)
    elseif event.key == "b" then
        main.shaketimer = 0.5
    elseif event.key == "y" then
        engine:removeEntity(playercutie)
    elseif event.key == "x" then
        engine:addEntity(ShotModel(playercutie.entity:getComponent("Position").x, (playercutie.entity:getComponent("Position").y + 50), love.mouse.getPosition()))
    end
end