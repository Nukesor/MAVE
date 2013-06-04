BoxDrawSystem = class("BoxDrawSystem", System)

function BoxDrawSystem:update()
	for index, value in pairs(self.targets) do
		
	end
end

function BoxDrawSystem:getRequiredComponents()
	return {"BoxComponent"}
end