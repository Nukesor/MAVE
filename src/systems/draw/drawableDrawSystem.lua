DrawableDrawSystem = class("DrawableDrawSystem", System)

function DrawableDrawSystem:__init()
    
    self.invert = love.graphics.newPixelEffect([[
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            vec4 effectiveColor = Texel(texture, texture_coords);
            return vec4(1.0-effectiveColor.rgb, effectiveColor.a);
        }
    ]])
    self.sortedTargets = {}
end

function DrawableDrawSystem:draw()
    love.graphics.setColor(255, 255, 255)
    for index, entity in ipairs(self.sortedTargets) do
        local drawable = entity:getComponent("DrawableComponent")
        local pos = entity:getComponent("PositionComponent")
        -- Enable to get inverted Colors
        --love.graphics.setPixelEffect(self.invert)

        -- Draws the Picture. If Entity is near to the beginng or the end of the screen, the Entity is drawed on both sides for sideChangeSystem animation.
        if pos.x < 50 then 
            love.graphics.draw(drawable.image, pos.x+1000, pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
        elseif pos.x > 950 then
            love.graphics.draw(drawable.image, pos.x-1000, pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
        end
        love.graphics.draw(drawable.image, pos.x, pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
        love.graphics.setPixelEffect()
    end
end

function DrawableDrawSystem:getRequiredComponents()
    return {"DrawableComponent", "PositionComponent", "ZIndex"}
end

function DrawableDrawSystem:addEntity(entity)
    -- Entitys are sorted by ZIndex, therefore we had to overwrite System:addEntity
    self.targets[entity.id] = entity
    self.sortedTargets = resetIndice(self.targets)
    table.sort(self.sortedTargets, function(a, b) return a:getComponent("ZIndex").index < b:getComponent("ZIndex").index end)
end

function DrawableDrawSystem:removeEntity(entity)
    -- Entitys are sorted by ZIndex, therefore we had to overwrite System:addEntity
    self.targets[entity.id] = nil
    self.sortedTargets = resetIndice(self.targets)
    table.sort(self.sortedTargets, function(a, b) return a:getComponent("ZIndex").index < b:getComponent("ZIndex").index end)
end