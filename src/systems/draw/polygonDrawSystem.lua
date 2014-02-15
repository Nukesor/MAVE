PolygonDrawSystem = class("PolygonDrawSystem", System)

function PolygonDrawSystem:draw()
    love.graphics.setColor(30, 60, 30)
    for index, entity in pairs(self.targets) do
        love.graphics.polygon("fill", entity:getComponent("DrawablePolygonComponent").body:getWorldPoints(
            entity:getComponent("DrawablePolygonComponent").shape:getPoints()))
    end
end

function PolygonDrawSystem:requires()
    return {"DrawablePolygonComponent"}
end