ItemBoxDrawSystem = class("ItemBoxDrawSystem", System)

function ItemBoxDrawSystem:__init()
    
    self.direction = true
end

function ItemBoxDrawSystem:draw()
    for index, value in pairs(self.targets) do
        local position = value:getComponent("PositionComponent")
        local box = value:getComponent("BoxComponent")

        -- Drawfunktion for Item-Boxes
        if box.image then
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(box.image, position.x+box.width/2, position.y+box.height/2, 0, box.scale, 
                box.scale, box.image:getWidth()/2, box.image:getHeight()/2)
        end
        if box.selected == true then
            love.graphics.setColor(255, 255, 255, 50)
            love.graphics.rectangle("fill", position.x, position.y, box.width, box.height)
        end
        if value:getComponent("ItemComponent") then
            local xscale
            local yscale
            if box.height / resources.images.sold:getHeight() < 1 then
                yscale = box.height / resources.images.sold:getHeight()
            else
                yscale = 1
            end
            if box.width / resources.images.sold:getWidth() < 1 then
                xscale = box.width / resources.images.sold:getWidth()
            else
                xscale = 1
            end
            if xscale < yscale then
                yscale = xscale
            else
                xscale = yscale
            end
            if value:getComponent("ItemComponent").owned == true then
                love.graphics.setColor(255, 255, 255, 255)
                love.graphics.draw(resources.images.sold, position.x+box.width/2, position.y+box.height/2, -0.125*math.pi, xscale, 
                    xscale, resources.images.sold:getWidth()/3, resources.images.sold:getHeight()/3)
            end
        end
    end
end

function ItemBoxDrawSystem:getRequiredComponents()
    return {"BoxComponent", "ItemComponent"}
end