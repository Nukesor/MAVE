BoxNavigationSystem = class("BoxNavigationSystem", System)

function BoxNavigationSystem:init()
end

function BoxNavigationSystem:fireEvent(event)
	local key = event.key
	local u = event.u
    if key == "left" or key == "a" then
    	self:changeSelected(1)
    elseif key == "right" or key == "d" then
    	self:changeSelected(2)
    elseif key == "up" or key == "w" then
    	self:changeSelected(3)
    elseif key == "down" or key == "s" then
    	self:changeSelected(4)
    elseif key == "return" then
		getSelectedBox():getComponent("FunctionComponent").func()
    end
end

function BoxNavigationSystem:getRequiredComponents()
	return {"BoxComponent"}
end

-- Setzt die verlinkte Entity auf selected und die momentan selektierte auf false. Aufbau der Table {links, rechts, oben, unten}
function BoxNavigationSystem:changeSelected(link) 
	local box = getSelectedBox()
    if box:getComponent("BoxComponent").linked[link] then
   	    box:getComponent("BoxComponent").selected = false
        box:getComponent("BoxComponent").linked[link]:getComponent("BoxComponent").selected = true
    end
end