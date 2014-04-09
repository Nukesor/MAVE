SettingNavigationSystem = class("SettingNavigationSystem", System)

function SettingNavigationSystem.fireEvent(self, event)
    local key = event.key
    local u = event.u
    -- Navigation with keys through linked Boxes
    if key == "left" or key == "a" then
        Menu:getSelectedBox():get("FunctionComponent").func("sub")
    elseif key == "right" or key == "d" then
        Menu:getSelectedBox():get("FunctionComponent").func("add")
    elseif key == "up" or key == "w" then
        self:changeSelected(3)
    elseif key == "down" or key == "s" then
        self:changeSelected(4)
    elseif key == "return" then
        Menu:getSelectedBox():get("FunctionComponent").func("add")
    end
end

function SettingNavigationSystem:requires()
    return {"BoxComponent"}
end

function SettingNavigationSystem:changeSelected(link) 
    local box = Menu:getSelectedBox()
    if box:get("BoxComponent").linked[link] then
           box:get("BoxComponent").selected = false
        box:get("BoxComponent").linked[link]:get("BoxComponent").selected = true
    end
end