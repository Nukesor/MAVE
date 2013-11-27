SettingNavigationSystem = class("SettingNavigationSystem", System)

function SettingNavigationSystem.fireEvent(self, event)
    local key = event.key
    local u = event.u
    -- Navigation with keys through linked Boxes
    if key == "left" or key == "a" then
        getSelectedBox():getComponent("FunctionComponent").func("sub")
    elseif key == "right" or key == "d" then
        getSelectedBox():getComponent("FunctionComponent").func("add")
    elseif key == "up" or key == "w" then
        self:changeSelected(3)
    elseif key == "down" or key == "s" then
        self:changeSelected(4)
    elseif key == "return" then
        getSelectedBox():getComponent("FunctionComponent").func("add")
    end
end

function SettingNavigationSystem:getRequiredComponents()
    return {"BoxComponent"}
end

function SettingNavigationSystem:changeSelected(link) 
    local box = getSelectedBox()
    if box:getComponent("BoxComponent").linked[link] then
           box:getComponent("BoxComponent").selected = false
        box:getComponent("BoxComponent").linked[link]:getComponent("BoxComponent").selected = true
    end
end