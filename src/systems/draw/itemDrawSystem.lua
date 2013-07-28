ItemDrawSystem = class("ItemDrawSystem", System)

-- Makes cuties carry the currently selected item
function ItemDrawSystem:draw() 
    for key, entity in pairs(self.targets) do
        local item = entity:getComponent("ItemComponent")
        local drawable = item.drawableEntity
        local mouseX, mouseY = love.mouse.getPosition()
        local entityX = entity:getComponent("PositionComponent").x
        local entityY = entity:getComponent("PositionComponent").y
        local x = mouseX - entityX
        local y = mouseY - entityY

        local sy = item.sy
        if x < 0 then
            sy = -sy
        end
        
        love.graphics.setColor(255,255,255)
        love.graphics.draw(item.image, entityX, entityY, math.atan2(x,-y)-(math.pi/2), item.sx, sy, 0, 0)
    end
end

function ItemDrawSystem:getRequiredComponents() 
    return {"ItemComponent", "PositionComponent"}
end