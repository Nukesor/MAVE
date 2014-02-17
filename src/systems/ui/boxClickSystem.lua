BoxClickSystem = class("BoxClickSystem", System)

function BoxClickSystem:mousePressed(event)
    local x = event.x 
    local y = event.y
    if event.button == "l" then
        local entity = self:getBoxAtPosition(x, y)
        if entity and entity:getComponent("DrawableComponent") then
            entity:getComponent("DrawableComponent").image = resources.images.button_pressed
        end
    end
end

function BoxClickSystem:mouseReleased(event)
    local x = event.x 
    local y = event.y  
    if event.button == "l" then
        for key, entity in pairs(stack:current().engine:getEntityList("BoxComponent")) do
            if entity:getComponent("DrawableComponent") then
                entity:getComponent("DrawableComponent").image = resources.images.button
            end
        end
        local entity = self:getBoxAtPosition(x, y)
        if entity then
            
            entity:getComponent("FunctionComponent"):func()
        end
    end
end

function BoxClickSystem:getBoxAtPosition(x, y)
    for index, entity in pairs(self.targets) do
        -- If mouse hovers over any box while clicking the left mousebotton, the box's function will be called.
        if (x >= entity:getComponent("PositionComponent").x) and (x <= (entity:getComponent("PositionComponent").x + entity:getComponent("BoxComponent").width)) then
            if (y >= entity:getComponent("PositionComponent").y) and (y <= (entity:getComponent("PositionComponent").y + entity:getComponent("BoxComponent").height)) then
                return entity
            end
        end    
    end
end

function BoxClickSystem:requires()
    return {"BoxComponent", "FunctionComponent"}
end