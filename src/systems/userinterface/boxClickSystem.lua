BoxClickSystem = class("BoxClickSystem", System)

function BoxClickSystem:fireEvent(event)
	local x = event.x 
	local y = event.y  
	local button = event.button
	if button == "l" then
		for index, box in pairs(self.targets) do
			-- If mouse hovers over any box while clicking the left mousebotton, the box's function will be called.
			if (x >= box:getComponent("PositionComponent").x) and (x <= (box:getComponent("PositionComponent").x + box:getComponent("BoxComponent").width)) then
				if (y >= box:getComponent("PositionComponent").y) and (y <= (box:getComponent("PositionComponent").y + box:getComponent("BoxComponent").height)) then
					box:getComponent("FunctionComponent"):func()
				end
			end	
		end
	end
end

function BoxClickSystem:getRequiredComponents()
	return {"BoxComponent"}
end