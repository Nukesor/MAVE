MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:fireEvent(event)
    -- Playercutie Jump
    if event.key == "p" or event.key == "escape" then
        local canvas = love.graphics.newScreenshot()
        screenshot = love.graphics.newImage(canvas)
        stack:push(pause)
    elseif event.key == "b" then
        main.shaketimer = 0.5
    end
    if tonumber(event.key) then
        if gameplay.items[tonumber(event.key)] then
            if gameplay.items[tonumber(event.key)][2] == true then
                playercutie:getComponent("ItemComponent").item = gameplay.items[tonumber(event.key)]
            else
                playercutie:getComponent("ItemComponent").item = nil
            end
        end
    end
end