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
	self.List = {"Life: ", "Damage: ", "Crit-Chance: "}
	self:load()
end

function GameOverState:load()
    love.graphics.setNewFont()
	self.index = 1
	self.c1Stats = nil
	self.c2Stats = nil
	self.c1Stats = {cutie1.life .. "/" .. (100+cutie1.mobbelity*10), "0-".. 5+cutie1.cuteness, string.format("%.2f %%",((2*cutie1.cuteness/(100+2*cutie1.cuteness))*100))}
	self.c2Stats = {cutie2.life .. "/" .. (100+cutie2.mobbelity*10), "0-".. 5+cutie2.cuteness, string.format("%.2f %%",((2*cutie2.cuteness/(100+2*cutie2.cuteness))*100))}
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

	for i = 1, 3, 1 do 
		local y = 100 + (i-1) * 15
		love.graphics.print(self.List[i], 100, y, 0, 1, 1 )
	end
	for i = 1, 3, 1 do 
		local y = 100 + (i-1) * 15
		love.graphics.print(self.List[i], 780, y, 0, 1, 1 )
	end

	for i = 1, 3, 1 do 
		local y = 100 + (i-1) * 15
		love.graphics.print(self.c1Stats[i], 180, y, 0, 1, 1 )
	end
	for i = 1, 3, 1 do 
		local y = 100 + (i-1) * 15
		love.graphics.print(self.c2Stats[i], 860, y, 0, 1, 1 )
	end

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
		cutie1.particles:reset()
		cutie2.particles:reset()
		if self.index == 1 then
			self:restart()
		elseif self.index == 2 then
			stack:pop()
			stack:pop()
		end
	end
end

function GameOverState:restart()
	cutie1:restart()
	cutie2:restart()
	stack:pop()
end