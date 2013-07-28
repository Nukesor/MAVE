BoxClickSystem = class("BoxClickSystem", System)

function BoxClickSystem:fireEvent(event)
	local x = event.x 
	local y = event.y  
	local button = event.button
	if button == "l" then
		for index, box in pairs(self.targets) do
			-- Falls die Maus ueber irgendeiner Box schwebt, waehrend geklickt wird, wird die verlinkte Funktion gecasted.
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