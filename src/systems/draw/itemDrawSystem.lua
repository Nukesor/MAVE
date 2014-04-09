ItemDrawSystem = class("ItemDrawSystem", System)

-- Makes cuties carry the currently selected item
function ItemDrawSystem:draw() 
    for key, entity in pairs(self.targets) do
        if entity:get("ItemComponent") then
            local item = entity:get("ItemComponent")
            local drawable = item.drawableEntity
            local mouseX, mouseY = love.mouse.getPosition()
            local entityX = entity:get("PositionComponent").x
            local entityY = entity:get("PositionComponent").y
            local x = mouseX - entityX
            local y = mouseY - entityY

            local sy = item.sy
            if x < 0 then
                sy = -sy
            end
            
            love.graphics.setColor(255,255,255)
            love.graphics.draw(item.image, entityX, entityY, math.atan2(x,-y)-(math.pi/2), item.sx * relation(), sy * relation(), item.image:getWidth()/4, item.image:getHeight()/3)
        end
    end
end

function ItemDrawSystem:requires() 
    return {"ItemComponent", "PositionComponent"}
end