MenuBoxDrawSystem = class("MenuBoxDrawSystem", System)

function MenuBoxDrawSystem:__init()
    
    self.direction = true
end

function MenuBoxDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local position = entity:getComponent("PositionComponent")
        local box = entity:getComponent("BoxComponent")
        local boxstring
        local scale = 1
        if entity:getComponent("UIStringComponent") then
            boxstring = entity:getComponent("UIStringComponent")
        end

        --print("font: " .. position.y)

        -- Drawfunktion for Menuboxes
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(boxstring.font)
        if box.selected == true then
            scale = scale*1.5
        end
        love.graphics.print(boxstring.string, position.x, position.y, 0, 
                scale, scale, 0, 0)
    end
end

function MenuBoxDrawSystem:getRequiredComponents()
    return {"BoxComponent", "UIStringComponent"}
end