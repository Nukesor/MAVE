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
            if playercutie:getComponent("ItemComponent") and playercutie:getComponent("ItemComponent").drawableEntity then
                    stack:current().engine:removeEntity(playercutie:getComponent("ItemComponent").drawableEntity)
                end
            if gameplay.items[tonumber(event.key)].owned == true then
                playercutie:addComponent(gameplay.items[tonumber(event.key)])
                playercutie:getComponent("ItemComponent").drawableEntity = Entity()
                stack:current().engine:addEntity(playercutie:getComponent("ItemComponent").drawableEntity)
            else
                playercutie:removeComponent("ItemComponent")
            end
        end
    end
end