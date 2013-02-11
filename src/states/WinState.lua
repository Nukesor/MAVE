require("objects/cutie") 
require("objects/walls")
require("core/resources")
require("core/helper")
require("core/state")

WinState =  class("WinState", State)

function WinState:__init()
	love.graphics.setFont(resources.fonts.font1)
	self.runner = 0
	self.menupoints = {"Give a Cookie",  "Pet your Pet", "Exit"}
	self.index = 0
end

function WinState:load()
	self.index = 0
	love.graphics.setNewFont()
end

function WinState:update(dt)
	self.runner = self.runner + dt/7
	if self.runner > 0.1 then
		self.runner = -0.1
	end
	love.timer.sleep(0.05)
	self.wobble = 1 + math.abs(self.runner)
end

function WinState:draw()
		self.x = 200

	love.graphics.draw(resources.images.arena)
	love.graphics.draw(resources.images.cutie2, 390, 200)

	for i = 1, 3, 1 do
		if (i-1) == self.index then
			love.graphics.print(self.menupoints[i], self.x, 500, 0, 3*self.wobble-0.25, 3*self.wobble)
		else
			love.graphics.print(self.menupoints[i], self.x, 500, 0, 2*self.wobble-0.25, 2*self.wobble)
		end
	self.x = self.x + 270
	end
end

function WinState:keypressed(key, u)
	if key == "right" or key ==  "d" then
		if self.index < 2 then
			self.index = self.index + 1
		elseif self.index == 2 then
			self.index = 0
		end
	elseif key == "left" or key == "a" then
		if self.index > 0 then
			self.index = self.index -1
		elseif self.index == 0 then
			self.index = 2
		end
	elseif key == "return" then
		if self.index == 0 then
			cutie1.mobbelity = cutie1.mobbelity + 1
			WinState:restart()
		elseif self.index == 1 then
			cutie1.cuteness = cutie1.cuteness + 1
			self:restart()
		elseif self.index == 2 then
			stack:pop()
			stack:pop()
		end
	end
end

function WinState:restart()
	cutie1:restart()
	cutie2:restart()
	stack:pop()
end