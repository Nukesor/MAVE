BuyEventSystem = class("BuyEventSystem", System)

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
		if gameplay.items[index] then
			gameplay.gold = gameplay.gold - gameplay.items[index][3]
			gameplay.items[index][2] = true
		end
	end
end