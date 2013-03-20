require("core/helper")
require("core/system")

RenderSystem = class("RenderSystem", System)

function RenderSystem:__init()
    self.targets = {}
    self.invert = love.graphics.newPixelEffect([[
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            vec4 effectiveColor = Texel(texture, texture_coords);
            return vec4(1.0-effectiveColor.rgb, effectiveColor.a);
        }
    ]])
end

function RenderSystem:update()
	love.graphics.setColor(255, 255, 255)
    for index, entity in ipairs(self.targets) do
        local drawable = entity:getComponent("Drawable")
        local pos = entity:getComponent("Position")
        -- Enable for teh lulz
        --love.graphics.setPixelEffect(self.invert)
        love.graphics.draw(drawable.image, pos.x, pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
        love.graphics.setPixelEffect()
    end
end

function RenderSystem:getRequiredComponents()
    return {"Drawable", "Position", "ZIndex"}
end

function RenderSystem:addEntity(entity)
    table.insert(self.targets, entity)
    table.sort(self.targets, function(a, b) return a:getComponent("ZIndex").index < b:getComponent("ZIndex").index end)
end