MenuBoxDrawSystem = class("MenuBoxDrawSystem", System)

function MenuBoxDrawSystem:__init()
    
    self.direction = true
end

function MenuBoxDrawSystem:draw()
    for index, value in pairs(self.targets) do
        local position = value:getComponent("PositionComponent")
        local box = value:getComponent("BoxComponent")
        local boxstring
        local scale
        if value:getComponent("MenuWobblyComponent") then
            scale = value:getComponent("MenuWobblyComponent").scale
        end
        if value:getComponent("UIStringComponent") then
            boxstring = value:getComponent("UIStringComponent")
        end

        -- Drawfunktion for Menuboxes
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(boxstring.font)
        if box.selected == true then
            if scale ~= nil then
                love.graphics.print(boxstring.string, position.x + box.width/2, position.y + box.height/2, 0, 
                    scale * 1.5, scale * 1.5, boxstring.font:getWidth(boxstring.string)/2, boxstring.font:getHeight(boxstring.string)/2)
            else
                love.graphics.print(boxstring.string, position.x + box.width/2, position.y + box.height/2, 0, 
                    scale, scale, boxstring.font:getWidth(boxstring.string)/2, boxstring.font:getHeight(boxstring.string)/2)
            end
        else
            love.graphics.print(boxstring.string, position.x + box.width/2, position.y + box.height/2, 0, 
                scale, scale, boxstring.font:getWidth(boxstring.string)/2, boxstring.font:getHeight(boxstring.string)/2)
        end
    end
end

function MenuBoxDrawSystem:getRequiredComponents()
    return {"BoxComponent", "UIStringComponent"}
end