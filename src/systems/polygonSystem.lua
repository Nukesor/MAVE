require("core/helper")
require("core/system")

PolygonSystem = class("PolygonSystem", System)

function PolygonSystem:update()
	love.graphics.setColor(50, 50, 50)
    for index, component in ipairs(self.targets) do
        love.graphics.polygon("fill", component.body:getWorldPoints(component.shape:getPoints()))
    end
end

function PolygonSystem:getRequiredComponents()
    return {"DrawablePolygon"}
end