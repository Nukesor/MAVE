GoldUpDisplaySystem = class("GoldUpDisplaySystem", System)

function GoldUpDisplaySystem:draw()
    for index, value in pairs(self.targets) do
        if value:getComponent("TimerComponent").time < 0 or value:getComponent("GoldUpComponent").transparency < 0 then
            stack:current().engine:removeEntity(value)
        else
            local position = value:getComponent("PositionComponent")
            love.graphics.setColor(150, 155, 0, value:getComponent("GoldUpComponent").transparency)
            love.graphics.setFont(resources.fonts.twenty)
            love.graphics.print("+ " .. value:getComponent("GoldUpComponent").gold, position.x, position.y-20)
            value:getComponent("PositionComponent").y = value:getComponent("PositionComponent").y - 1
            value:getComponent("GoldUpComponent").transparency =  value:getComponent("GoldUpComponent").transparency - 10
        end
    end
end

function GoldUpDisplaySystem:getRequiredComponents()
    return {"TimerComponent", "GoldUpComponent"}
end