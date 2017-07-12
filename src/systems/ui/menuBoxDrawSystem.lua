MenuBoxDrawSystem = class("MenuBoxDrawSystem", System)

function MenuBoxDrawSystem:initialize()
    self.direction = true
end

function MenuBoxDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local box = entity:get("BoxComponent")
        local boxstring = entity:get("UIStringComponent")
        local scale = 1

        -- Drawfunktion for Menuboxes
        love.graphics.setColor(160, 160, 160, 255)
        love.graphics.setFont(boxstring.font)
        if box.selected == true then
            scale = scale*1.1
        end
        love.graphics.print(boxstring.string, boxstring.x, boxstring.y, 0,
                scale*relation(), scale*relation(), 0, 0)
    end
end

function MenuBoxDrawSystem:requires()
    return {"BoxComponent", "UIStringComponent"}
end
