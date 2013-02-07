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
	if key == "right" or "left" then
		if self.index == 1 then
			self.index = 0 
		elseif self.index == 0 then
			self.index = 1
		end
	elseif key == "return" then
		if self.index == 0 then
			self:restart()
		elseif self.index == 1 then
			stack:pop()
			main:destroy()
			stack:pop()
		end
	end
end

function WinState:restart()
	cutie1.life = 100 + 10*cutie1.mobbelity
	cutie2.life = 100 + 10*cutie2.mobbelity
	cutie1.body:setX(333)
	cutie2.body:setX(666)
	cutie1.body:setY(400)
	cutie2.body:setY(400)
	cutie1.body:setLinearVelocity(math.random(-70, 70), math.random(-40, 40))
	cutie2.body:setLinearVelocity(math.random(-70, 70), math.random(-40, 40))
	stack:pop()
end