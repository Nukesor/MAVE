BloodUpDisplaySystem = class("BloodUpDisplaySystem", System)

function BloodUpDisplaySystem:draw()
    for index, value in pairs(self.targets) do
        if value:getComponent("TimerComponent").time < 0 or value:getComponent("BloodUpComponent").transparency < 0 then
            stack:current().engine:removeEntity(value)
        else
            local position = value:getComponent("PositionComponent")
            love.graphics.setColor(200, 0, 0, value:getComponent("BloodUpComponent").transparency)
            love.graphics.setFont(resources.fonts.twentyfive)
            love.graphics.print("+ " .. value:getComponent("BloodUpComponent").blood, position.x, position.y-20)
            value:getComponent("PositionComponent").y = value:getComponent("PositionComponent").y - 1
            value:getComponent("BloodUpComponent").transparency =  value:getComponent("BloodUpComponent").transparency - 5
        end
    end
end

function BloodUpDisplaySystem:requires()
    return {"TimerComponent", "BloodUpComponent"}
end