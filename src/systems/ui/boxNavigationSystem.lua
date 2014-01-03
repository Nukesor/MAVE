BoxNavigationSystem = class("BoxNavigationSystem", System)

function BoxNavigationSystem.fireEvent(self, event)
    local key = event.key
    local u = event.u
    -- Navigation with keys through linked Boxes
    if key == "left" or key == "a" then
        self:changeSelected(1)
    elseif key == "right" or key == "d" then
        self:changeSelected(2)
    elseif key == "up" or key == "w" then
        self:changeSelected(3)
    elseif key == "down" or key == "s" then
        self:changeSelected(4)
    elseif key == "return" then
        Menu:getSelectedBox():getComponent("FunctionComponent").func()
    end
end

function BoxNavigationSystem:getRequiredComponents()
    return {"BoxComponent"}
end

function BoxNavigationSystem:changeSelected(link) 
    local box = Menu:getSelectedBox()
    if box:getComponent("BoxComponent").linked[link] then
           box:getComponent("BoxComponent").selected = false
        box:getComponent("BoxComponent").linked[link]:getComponent("BoxComponent").selected = true
    end
end