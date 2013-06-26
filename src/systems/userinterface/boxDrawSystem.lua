BoxDrawSystem = class("BoxDrawSystem", System)

function BoxDrawSystem:__init()
	self.__super.__init(self)
	self.scale = 1
	self.direction = true
end

function BoxDrawSystem:update(dt)

	if self.direction == true then
		self.scale = self.scale + 0.003
		if self.scale > 1.2 then
			self.direction = false
		end
	else
		self.scale = self.scale - 0.003
		if self.scale < 1 then
			self.direction = true
		end
	end

	for index, value in pairs(self.targets) do
		local position = value:getComponent("PositionComponent")
		local box = value:getComponent("BoxComponent")
		local boxstring
		if value:getComponent("StringComponent") then
			boxstring = value:getComponent("StringComponent")
			end
		if box.typ == "item" then	
			love.graphics.setColor(200, 50, 0, 255)
			love.graphics.rectangle("line", position.x, position.y, box.width, box.height)
			love.graphics.setColor(100, 100, 100, 100)
			love.graphics.rectangle("fill", position.x+2, position.y+2, box.width-4, box.height-4)
		elseif box.typ == "menu" then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.setFont(boxstring.font)
			if box.selected == true then
				love.graphics.print(boxstring.string, position.x - boxstring.font:getWidth(boxstring.string)/2, position.y - boxstring.font:getHeight(boxstring.string)/2, 0, self.scale, self.scale)
			else
				love.graphics.print(boxstring.string, position.x - boxstring.font:getWidth(boxstring.string)/2, position.y - boxstring.font:getHeight(boxstring.string)/2)
			end
		end
	end
end

function BoxDrawSystem:getRequiredComponents()
	return {"BoxComponent"}
end