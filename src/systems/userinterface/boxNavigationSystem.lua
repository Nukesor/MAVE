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
    	local box = self.selectedBox
        box:getComponent("BoxComponent").selected = false
        box:getComponent("BoxComponent").linked[1]:getComponent("BoxComponent").selected = true
        self.selectedBox = box:getComponent("BoxComponent").linked[1]
    elseif key == "right" or key == "d" then
    	local box = self.selectedBox
   	    box:getComponent("BoxComponent").selected = false
        box:getComponent("BoxComponent").linked[2]:getComponent("BoxComponent").selected = true
        self.selectedBox = box:getComponent("BoxComponent").linked[2]
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