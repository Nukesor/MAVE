require("core/helper")
require("core/system")

RenderSystem = class("RenderSystem", System)

function RenderSystem:update()
	love.graphics.setColor(255, 255, 255)
    for index, entity in pairs(self.targets) do
        local drawable = entity:getComponent("Drawable")
        local pos = entity:getComponent("Position")
        love.graphics.draw(drawable.image, pos.x, pos.y, drawable.r, drawable.sx, drawable.sy, drawable.ox, drawable.oy)
    end
end

function RenderSystem:getRequiredComponents()
    return {"Drawable", "Position", "ZIndex"}
end

function RenderSystem:addEntity(entity)
    self.targets[entity:getComponent("ZIndex").index] = entity
end