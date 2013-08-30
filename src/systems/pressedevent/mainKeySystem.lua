MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:fireEvent(event)
    -- Playercutie Jump
    if event.key == "p" or event.key == "escape" then
        local canvas = love.graphics.newScreenshot()
        pause.screenshot = love.graphics.newImage(canvas)
        stack:push(pause)
    elseif event.key == "b" then
        main.shaketimer = 0.5
    elseif event.key == "o" then
        playercutie:getComponent("LifeComponent").life = 0
    end
    if tonumber(event.key) then
        if gameplay.items[tonumber(event.key)] then
            if gameplay.items[tonumber(event.key)].owned == true then
                playercutie:addComponent(gameplay.items[tonumber(event.key)])
                stack:current().engine:refreshEntity(playercutie, {"ItemComponent"}, {})
            else
                playercutie:removeComponent("ItemComponent")
                stack:current().engine:refreshEntity(entity, {}, {"ItemComponent"})
            end
        end
    end
end