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
			gameplay.gold = gameplay.gold - gameplay.items[index].price
			gameplay.items[index].owned = true
		end
	end
end