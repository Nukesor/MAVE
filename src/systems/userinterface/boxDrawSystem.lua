BoxDrawSystem = class("BoxDrawSystem", System)

function BoxDrawSystem:__init()
	
	self.direction = true
end

function BoxDrawSystem:draw()
	for index, value in pairs(self.targets) do
		local position = value:getComponent("PositionComponent")
		local box = value:getComponent("BoxComponent")
		local boxstring
		local scale
		if value:getComponent("MenuWobblyComponent") then
			scale = value:getComponent("MenuWobblyComponent").scale
		end
		if value:getComponent("UIStringComponent") then
			boxstring = value:getComponent("UIStringComponent")
		end

		-- Drawfunktion for Boxes
		if box.typ == "item" then	
			if value:getComponent("ImageComponent") then
				love.graphics.draw(value:getComponent("ImageComponent").image, position.x, position.y)
			end
			love.graphics.setColor(200, 50, 0, 255)
			love.graphics.rectangle("line", position.x, position.y, box.width, box.height)
			love.graphics.setColor(100, 100, 100, 100)
			love.graphics.rectangle("fill", position.x+2, position.y+2, box.width-4, box.height-4)
			if box.selected == true then
				love.graphics.setColor(255, 255, 255, 50)
				love.graphics.rectangle("fill", position.x, position.y, box.width, box.height)
			end

		-- Drawfunktion for Menuboxes
		elseif box.typ == "menu" then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.setFont(boxstring.font)
			if box.selected == true then
				if scale ~= nil then
					love.graphics.print(boxstring.string, position.x + box.width/2, position.y + box.height/2, 0, scale * 1.5, scale * 1.5, boxstring.font:getWidth(boxstring.string)/2, boxstring.font:getHeight(boxstring.string)/2)
				else
					love.graphics.print(boxstring.string, position.x + box.width/2, position.y + box.height/2, 0, scale, scale, boxstring.font:getWidth(boxstring.string)/2, boxstring.font:getHeight(boxstring.string)/2)
				end
			else
				love.graphics.print(boxstring.string, position.x + box.width/2, position.y + box.height/2, 0, scale, scale, boxstring.font:getWidth(boxstring.string)/2, boxstring.font:getHeight(boxstring.string)/2)
			end
		end
	end
end

function BoxDrawSystem:getRequiredComponents()
	return {"BoxComponent"}
end