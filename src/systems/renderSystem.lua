require("core/helper")
require("core/system")

RenderSystem = class("RenderSystem", System)

function RenderSystem:update()
	love.graphics.setColor(255, 255, 255)
    for index, component in ipairs(self.targets) do
        love.graphics.draw(component.image, component.x, component.y, component.r, component.sx, component.sy, component.ox, component.oy)
    end
end

function RenderSystem:getRequiredComponents()
    return {"Drawable"}
end