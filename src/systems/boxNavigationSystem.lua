BoxNavigationSystem = class("BoxNavigationSystem", System)

function BoxNavigationSystem:init()
	self.__super.__init(self)
end

function BoxNavigationSystem:fireEvent(event)
	local key = event.key
	local u = event.u
    if key == "left" or key == "a" then
    	local box = self:getSelectedBox()
        box:getComponent("BoxComponent").selected = false
        box:getComponent("BoxComponent").linked[1]:getComponent("BoxComponent").selected = true
    elseif key == "right" or key == "d" then
    	local box = self:getSelectedBox()
   	    box:getComponent("BoxComponent").selected = false
        box:getComponent("BoxComponent").linked[2]:getComponent("BoxComponent").selected = true
    elseif key == "return" then
		self:getSelectedBox():getComponent("BoxComponent").func()
    end
end

function BoxNavigationSystem:getRequiredComponents()
	return {"BoxComponent"}
end

function BoxNavigationSystem:getSelectedBox()
	for index, value in pairs(self.targets) do
		if value:getComponent("BoxComponent").selected == true then 
			return value
		end
	end
end