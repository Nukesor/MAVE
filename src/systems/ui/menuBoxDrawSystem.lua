MenuBoxDrawSystem = class("MenuBoxDrawSystem", System)

function MenuBoxDrawSystem:__init()
    
    self.direction = true
end

function MenuBoxDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local position = entity:getComponent("PositionComponent")
        local box = entity:getComponent("BoxComponent")
        local boxstring = entity:getComponent("UIStringComponent")
        local scale = 1

        -- Drawfunktion for Menuboxes
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(boxstring.font)
        if box.selected == true then
            scale = scale*1.5
        end
        love.graphics.print(boxstring.string, position.x, position.y, 0, 
                scale*relation(), scale*relation(), 0, 0)
    end
end

function MenuBoxDrawSystem:requires()
    return {"BoxComponent", "UIStringComponent"}
end