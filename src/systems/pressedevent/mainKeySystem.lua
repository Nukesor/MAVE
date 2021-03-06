MainKeySystem = class("MainKeySystem", System)

function MainKeySystem.fireEvent(self, event)
    -- Playercutie Jump
    if event.key == "p" or event.key == "escape" then
        local canvas = love.graphics.newScreenshot()
        local screenshot = love.graphics.newImage(canvas)
        stack:push(PauseState(screenshot))
    elseif event.key == "b" then
        stack:current().shaketimer = 0.5
    elseif event.key == "o" then
        local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
        playercutie:get("LifeComponent").life = 0
    elseif event.key == "i" then
        local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
        playercutie:get("LifeComponent").life = 15
    end
    if event.key == "[" then
        stack:current().engine:removeSystem("DrawableDrawSystem", "draw")
    elseif event.key == "]" then
        stack:current().engine:addSystem(DrawableDrawSystem(), "draw", 1)
    end

    -- If any numberkey is pressed, the linked Item will be selected.
    if tonumber(event.key) then
        if gameplay.items[tonumber(event.key)] then
            local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
            if gameplay.items[tonumber(event.key)].owned == true then
                playercutie:add(gameplay.items[tonumber(event.key)])
            elseif playercutie:get("ItemComponent") then
                playercutie:remove("ItemComponent")
            end
        end
    end
end
