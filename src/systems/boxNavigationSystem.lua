BoxNavigationSystem = class("BoxNavigationSystem", System)

function BoxNavigationSystem:init()
	self.super.__init(self)

end

function BoxNavigationSystem:keypressed(key, unicode)
    if key == "left" or key == "a" then
        self:getSelectedBox():getComponent("BoxComponent").selected = false
        self:getSelectedBox():getComponent("BoxComponent").linked[1]:getComponent("BoxComponent").selected = true
    
    else if key == "right" or key == "d" then
   	    self:getSelectedBox():getComponent("BoxComponent").selected = false
        self:getSelectedBox():getComponent("BoxComponent").linked[2]:getComponent("BoxComponent").selected = true

    else if key == "return" then
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