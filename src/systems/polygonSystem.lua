require("core/helper")
require("core/system")

PolygonSystem = class("PolygonSystem", System)

function PolygonSystem:update()
	love.graphics.setColor(50, 50, 50)
    for index, entity in ipairs(self.targets) do
        local drawable = entity:getComponent("DrawablePolygon")
        love.graphics.polygon("fill", drawable.body:getWorldPoints(drawable.shape:getPoints()))
    end
end

function PolygonSystem:getRequiredComponents()
    return {"DrawablePolygon"}
end