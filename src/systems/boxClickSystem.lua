BoxClickSystem = class("BoxClickSystem", System)

function BoxClickSystem:mouseclicked(x, y, button)
	for index, value in pairs(self.targets) do
		if button == 'l' then
			if (x >= value:getComponent("PositionComponent").x) and (x <= (value:getComponent("PositionComponent").x + value:getComponent("BoxComponent").length)) then
				if (y >= value:getComponent("PositionComponent").y) and (y <= (value:getComponent("PositionComponent").y + value:getComponent("BoxComponent").height)) then
					self:getSelectedBox():getComponent("BoxComponent").selected = false
					value:getComponent("BoxComponent").selected = true
					value:getComponent("BoxComponent").func()
				end
			end	
		end
	end
end

function BoxClickSystem:getRequiredComponents()
	return {"BoxComponent"}
end

function BoxClickSystem:getSelectedBox()
	for index, value in pairs(self.targets) do
		if value:getComponent("BoxComponent").selected == true then
			return value
		end
	end
end