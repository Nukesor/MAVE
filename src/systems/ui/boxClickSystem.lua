BoxClickSystem = class("BoxClickSystem", System)

function BoxClickSystem:fireEvent(event)
    local x = event.x 
    local y = event.y  
    local button = event.button
    if button == "l" then
        for index, entity in pairs(self.targets) do
            -- If mouse hovers over any box while clicking the left mousebotton, the box's function will be called.
            if (x >= entity:getComponent("PositionComponent").x) and (x <= (entity:getComponent("PositionComponent").x + entity:getComponent("BoxComponent").width)) then
                if (y >= entity:getComponent("PositionComponent").y) and (y <= (entity:getComponent("PositionComponent").y + entity:getComponent("BoxComponent").height)) then
                    entity:getComponent("FunctionComponent"):func()
                end
            end    
        end
    end
end

function BoxClickSystem:requires()
    return {"BoxComponent"}
end