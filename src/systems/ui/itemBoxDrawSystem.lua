ItemBoxDrawSystem = class("ItemBoxDrawSystem", System)

function ItemBoxDrawSystem:__init()
    
    self.direction = true
end

function ItemBoxDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local position = entity:getComponent("PositionComponent")
        local box = entity:getComponent("BoxComponent")

        -- Drawfunktion for Item-Boxes
        if box.image then
            if (gameplay.stats.blood - entity:getComponent("ItemComponent").price ) < 0 and entity:getComponent("ItemComponent").owned == false then
                love.graphics.setColor(100, 100, 100, 255)
            else
                love.graphics.setColor(255, 255, 255, 255)
            end
            love.graphics.draw(box.image, position.x+box.width/2, position.y+box.height/2, 0, box.scale, 
                box.scale, box.image:getWidth()/2, box.image:getHeight()/2)
        end
        if box.selected == true then
            love.graphics.setColor(255, 255, 255, 50)
            love.graphics.rectangle("fill", position.x, position.y, box.width, box.height)
        end
        if entity:getComponent("ItemComponent") then
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
            if entity:getComponent("ItemComponent").owned == true then
                love.graphics.setColor(255, 255, 255, 255)
                love.graphics.draw(resources.images.sold, position.x+box.width/2, position.y+box.height/2, -0.125*math.pi, xscale, 
                    xscale, resources.images.sold:getWidth()/3, resources.images.sold:getHeight()/3)
            end
        end
    end
end

function ItemBoxDrawSystem:requires()
    return {"BoxComponent", "ItemComponent"}
end