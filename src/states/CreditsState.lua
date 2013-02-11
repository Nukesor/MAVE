require("core/helper")
require("core/resources")

CreditsState = class("CreditsState", State)

function CreditsState:__init()
	self.bg = resources.images.arena
	self.names = {"Code:\nArne Beer\nRafael Epplée", "Graphics:\nRafael Epplée", "Sounds:\nToenjes Peters", 
					"Idea:\nPaul Bienkowski\nSven-Hendrik Haase\nHans-Ole Hatzel\nToenjes Peters\nRafael Epplée\nArne Beer"}
	self.y = 100
end

function CreditsState:load()
	love.graphics.setNewFont(20)
end

function CreditsState:draw()
	love.graphics.draw(self.bg, 0, 0)

	for i = 1, #self.names, 1 do
		love.graphics.print(self.names[i], 50, self.y+(i*60))
	end
end

function CreditsState:keypressed(key, u)
	stack:push(menu)
end