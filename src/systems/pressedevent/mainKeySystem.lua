MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:fireEvent(event)
    -- Playercutie Jump
    if event.key == "p" or event.key == "escape" then
        local canvas = love.graphics.newScreenshot()
        local screenshot = love.graphics.newImage(canvas)
        stack:push(PauseState(screenshot))
    elseif event.key == "b" then
        stack:current().shaketimer = 0.5
    elseif event.key == "o" then
        playercutie:getComponent("LifeComponent").life = 0
    end
    if event.key == "[" then
        stack:current().engine:removeSystem("DrawableDrawSystem", "draw")
    elseif event.key == "]" then
        stack:current().engine:addSystem(DrawableDrawSystem(), "draw")
    end

    -- If any numberkey is pressed, the linked Item will be selected.
    if tonumber(event.key) then
        if gameplay.items[tonumber(event.key)] then
            if gameplay.items[tonumber(event.key)].owned == true then
                playercutie:addComponent(gameplay.items[tonumber(event.key)])
                stack:current().engine:componentAdded(playercutie, {"ItemComponent"})
            elseif playercutie:getComponent("ItemComponent") then
                playercutie:removeComponent("ItemComponent")
                stack:current().engine:componentRemoved(playercutie, {"ItemComponent"})
            end
        end
    end
end