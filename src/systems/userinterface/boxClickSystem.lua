BoxClickSystem = class("BoxClickSystem", System)

function BoxClickSystem:fireEvent(event)
	local x = event.x 
	local y = event.y  
	local button = event.button
	if button == "l" then
		for index, value in pairs(self.targets) do
			-- Falls die Maus ueber irgendeiner Box schwebt, waehrend geklickt wird, wird die verlinkte Funktion gecasted.
			if (x >= value:getComponent("PositionComponent").x) and (x <= (value:getComponent("PositionComponent").x + value:getComponent("BoxComponent").width)) then
				if (y >= value:getComponent("PositionComponent").y) and (y <= (value:getComponent("PositionComponent").y + value:getComponent("BoxComponent").height)) then
					value:getComponent("FunctionComponent"):func()
				end
			end	
		end
	end
end

function BoxClickSystem:getRequiredComponents()
	return {"BoxComponent"}
end