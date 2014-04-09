BloodUpDisplaySystem = class("BloodUpDisplaySystem", System)

function BloodUpDisplaySystem:draw()
    for index, value in pairs(self.targets) do
        if value:get("TimerComponent").time < 0 or value:get("BloodUpComponent").transparency < 0 then
            stack:current().engine:removeEntity(value)
        else
            local position = value:get("PositionComponent")
            love.graphics.setColor(200, 0, 0, value:get("BloodUpComponent").transparency)
            love.graphics.setFont(resources.fonts.twentyfive)
            love.graphics.print("+ " .. value:get("BloodUpComponent").blood, position.x, position.y-20)
            value:get("PositionComponent").y = value:get("PositionComponent").y - 1
            value:get("BloodUpComponent").transparency =  value:get("BloodUpComponent").transparency - 5
        end
    end
end

function BloodUpDisplaySystem:requires()
    return {"TimerComponent", "BloodUpComponent"}
end