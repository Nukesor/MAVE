require("core/class")
require("core/system")

DrawableDrawSystem = class("DrawableDrawSystem", System)

function DrawableDrawSystem:__init()
    self.__super.__init(self)
    self.invert = love.graphics.newPixelEffect([[
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            vec4 effectiveColor = Texel(texture, texture_coords);
            return vec4(1.0-effectiveColor.rgb, effectiveColor.a);
        }
    ]])
end

function DrawableDrawSystem:update()
    love.graphics.setColor(255, 255, 255)
    for index, entity in ipairs(self.targets) do
        local drawable = entity:getComponent("DrawableComponent")
        local pos = entity:getComponent("PositionComponent")
        -- Enable for teh lulz
        --love.graphics.setPixelEffect(self.invert)
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
    table.insert(self.targets, entity)
    table.sort(self.targets, function(a, b) return a:getComponent("ZIndex").index < b:getComponent("ZIndex").index end)
end

function DrawableDrawSystem:removeEntity(entity)
    for index, value in pairs(self.targets) do
        if value == entity then
            table.remove(self.targets, index)
            table.sort(self.targets, function(a, b) return a:getComponent("ZIndex").index < b:getComponent("ZIndex").index end)
            break
        end
    end
end