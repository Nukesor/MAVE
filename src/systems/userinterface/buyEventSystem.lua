BuyEventSystem = class("BuyEventSystem", System)

function BuyEventSystem:__init()
	print("Wird erstellt")
end

function BuyEventSystem:fireEvent(event)
	print("Event fired")
	if event.boolean == true then
		-- Selected Box finden
		local box = getSelectedBox()
		local index
		for i, v in pairs(self.targets) do
			if v == box then
				index = i 
			end
		end
		if box then 
			print("Box found")
			print(index)
		end
		--Gold abziehen
		if gameplay.items[i] then
			gameplay.gold = gameplay.gold - gameplay.items[i][3]
			gameplay.items[i][2] = true
		end
	end
end

function BuyEventSystem:getRequiredComponents()
	return {"BoxComponent"}
end