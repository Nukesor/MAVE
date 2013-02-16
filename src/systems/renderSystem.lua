require("core/system")

RenderSystem = class("RenderSystem")

function RenderSystem:process()
    for index, component in ipairs(self.targets) do
        love.graphics.draw(component.image, component.x, component.y, component.sx, component.sy, component.ox, component.oy)
    end
end