MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:fireEvent(event)
    -- Playercutie Jump
    if event.key == "p" or event.key == "escape" then
        local canvas = love.graphics.newScreenshot()
        pause.screenshot = love.graphics.newImage(canvas)
        stack:push(pause)
    elseif event.key == "b" then
        main.shaketimer = 0.5
    end
    if tonumber(event.key) then
        if gameplay.items[tonumber(event.key)] then
            print(gameplay.items[tonumber(event.key)].name)
            if gameplay.items[tonumber(event.key)].owned == true then
                playercutie:addComponent(gameplay.items[tonumber(event.key)])
                for k,v in pairs(playercutie:getComponent("ItemComponent")) do
                    print(k,v)
                end
            else
                playercutie:getComponent("ItemComponent").item = nil
            end
        end
    end
end