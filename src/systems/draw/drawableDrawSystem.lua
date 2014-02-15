DrawableDrawSystem = class("DrawableDrawSystem", System)

function DrawableDrawSystem:__init()
    
    self.sortedTargets = {}
end

function DrawableDrawSystem:draw()
    love.graphics.setColor(255, 255, 255)
    for index, entity in ipairs(self.sortedTargets) do
        local drawable = entity:getComponent("DrawableComponent")
        local pos = entity:getComponent("PositionComponent")

        -- Draws the Picture. If Entity is near to the beginng or the end of the screen, the Entity is drawed on both sides for sideChangeSystem animation.
        if pos.x < love.graphics.getWidth()/20 then 
            love.graphics.draw(drawable.image, pos.x+love.graphics.getWidth(), pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
        elseif pos.x > love.graphics.getWidth() * (19/20) then
            love.graphics.draw(drawable.image, pos.x-love.graphics.getWidth(), pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
        end
        love.graphics.draw(drawable.image, pos.x, pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
    end
end

function DrawableDrawSystem:requires()
    return {"DrawableComponent", "PositionComponent", "ZIndex"}
end

function DrawableDrawSystem:addEntity(entity)
    -- Entitys are sorted by ZIndex, therefore we had to overwrite System:addEntity
    self.targets[entity.id] = entity
    self.sortedTargets = table.resetIndice(self.targets)
    table.sort(self.sortedTargets, function(a, b) return a:getComponent("ZIndex").index < b:getComponent("ZIndex").index end)
end

function DrawableDrawSystem:removeEntity(entity)
    -- Entitys are sorted by ZIndex, therefore we had to overwrite System:addEntity
    self.targets[entity.id] = nil
    self.sortedTargets = table.resetIndice(self.targets)
    table.sort(self.sortedTargets, function(a, b) return a:getComponent("ZIndex").index < b:getComponent("ZIndex").index end)
end