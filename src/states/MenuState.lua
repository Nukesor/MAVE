require("objects/cutie") 
require("objects/walls")
require("core/resources")
require("core/helper")

MenuState = class("MenuState")

function MenuState:__init()
	love.graphics.setFont(resources.fonts.font1)
	self.menupoints = {"Credits","Play","Exit"}
	self.index = 1
end

function MenuState:update()
	 love.timer.sleep(0.2)
end

function MenuState:draw()

	self.x = 250

	love.graphics.draw(resources.images.arena)
	love.graphics.draw(resources.images.cutie2, 390, 200)

	for i = 1, 3, 1 do
		if (i-1) == self.index then
			love.graphics.print(self.menupoints[i], self.x, 500, 0, 2.5, 2.5)
		else
			love.graphics.print(self.menupoints[i], self.x, 500, 0, 2, 2)
	end
	self.x = self.x + 250
	end

	function MenuState:keypressed(key, u)
		if key == "up" then
			self.index = (self.index +1) % 3
		elseif key == "down" then
			if self.index > 0 then
				self.index = (self.index -1) % 3
			elseif self.index == 0 then
				self.index = 2
			end
		elseif key == "enter" then
			if self.index == 0 then
				love.graphics.print("not working yet", 20, 20)
			elseif self.index == 1 then
				states:push(main)
			elseif self.index == 2 then
				love.event.push("quit")
			end
		elseif key == "escape" then
			love.event.push("quit")
		end
	end
end
