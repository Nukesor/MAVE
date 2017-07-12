BoxHoverSystem = class("BoxHoverSystem", System)

function BoxHoverSystem:initialize()
    self.x = 0
    self.y = 0
end

function BoxHoverSystem:update(dt)
    local x, y = love.mouse.getPosition()
    if self.x ~= x or self.y ~= y then
        self.x = x
        self.y = y
        for index, value in pairs(self.targets) do
            -- If mouse hovers over any Box, the Box will be selected.
            if (x >= value:get("PositionComponent").x) and (x <= (value:get("PositionComponent").x + value:get("BoxComponent").width)) then
                if (y >= value:get("PositionComponent").y) and (y <= (value:get("PositionComponent").y + value:get("BoxComponent").height)) then
                    Menu:getSelectedBox():get("BoxComponent").selected = false
                    value:get("BoxComponent").selected = true
                end
            end
        end
    end
end

function BoxHoverSystem:requires()
    return {"BoxComponent"}
end
