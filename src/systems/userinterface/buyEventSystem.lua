BuyEventSystem = class("BuyEventSystem", System)

function BuyEventSystem:__init()

end

function BuyEventSystem:fireEvent(event)
	if event.boolean == true then
		-- Selected Box finden
		local box = getSelectedBox()
		local index
		for i, v in pairs(stack:current().boxes) do
			if v == box then
				index = i 
			end
		end
		--Gold abziehen
		if gameplay.items[i] then
			gameplay.gold = gameplay.gold - gameplay.items[i][3]
			gameplay.items[i][2] == true
		end
	end
end
