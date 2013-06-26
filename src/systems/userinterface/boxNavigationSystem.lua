BoxNavigationSystem = class("BoxNavigationSystem", System)

function BoxNavigationSystem:init()
	self.__super.__init(self)
	self.selectedBox = nil
end

function BoxNavigationSystem:fireEvent(event)
	if self.selectedBox == nil then
		self.selectedBox = self:getSelectedBox()
	end

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
		self:getSelectedBox():getComponent("FunctionComponent").func()
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

function BoxNavigationSystem:changeSelected(link) 
		local box = self.selectedBox
   	    box:getComponent("BoxComponent").selected = false
        box:getComponent("BoxComponent").linked[link]:getComponent("BoxComponent").selected = true
        self.selectedBox = box:getComponent("BoxComponent").linked[link]
end