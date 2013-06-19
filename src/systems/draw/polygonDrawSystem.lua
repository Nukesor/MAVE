PolygonDrawSystem = class("PolygonDrawSystem", System)

function PolygonDrawSystem:update(dt)
    love.graphics.setColor(50, 50, 50)
    for index, entity in pairs(self.targets) do
        love.graphics.polygon("fill", entity:getComponent("DrawablePolygonComponent").body:getWorldPoints(entity:getComponent("DrawablePolygonComponent").shape:getPoints()))
    end
end

function PolygonDrawSystem:getRequiredComponents()
    return {"DrawablePolygonComponent"}
end