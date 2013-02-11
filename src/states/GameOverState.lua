require("objects/cutie") 
require("objects/walls")
require("core/resources")
require("core/helper")
require("core/state")

GameOverState =  class("GameOverState", State)

function GameOverState:__init()
	love.graphics.setFont(resources.fonts.font1)
	self.runner = 0
	self.mode = 0
	self.menupoints = {"Play Again", "Exit"}
	self.index = 1
end

function GameOverState:load()
	self.index = 1
    love.graphics.setNewFont()
end


function GameOverState:update(dt)
	self.runner = self.runner + dt/7
	if self.runner > 0.1 then
		self.runner = -0.1
	end
	love.timer.sleep(0.05)
	self.wobble = 1 + math.abs(self.runner)
end

function GameOverState:draw()
		self.x = 333

	love.graphics.draw(resources.images.arena)
	love.graphics.draw(resources.images.cutie2, 390, 200)

	for i = 1, 2, 1 do
		if i == self.index then
			love.graphics.print(self.menupoints[i], self.x, 500, 0, 3*self.wobble-0.25, 3*self.wobble)
		else
			love.graphics.print(self.menupoints[i], self.x, 500, 0, 2*self.wobble-0.25, 2*self.wobble)
		end
	self.x = self.x + 333
	end
end

function GameOverState:keypressed(key, u)
	if key == "left" or key == "right" or key == "a" or key == "d" then
		if self.index == 1 then
			self.index = 2 
		elseif self.index == 2 then
			self.index = 1
		end
	elseif key == "return" then
		if self.index == 1 then
			self:restart()
		elseif self.index == 2 then
			GameOverState:restart()
			stack:pop()
		end
	end
end

function GameOverState:restart()
	cutie1:restart()
	cutie2:restart()
	stack:pop()
end