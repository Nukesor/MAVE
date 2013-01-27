require("core/helper")

Resources = class("Resources")

function Resources:__init()
    
	self.imageQueue = {}
    self.musicQueue = {}

	self.images = {}
    self.music = {}
end

function Resources:addImage(name, src)
    self.imageQueue[name] = src
end

function Resources:addMusic(name, src)
    self.musicQueue[name] = src
end

function Resources:load()

    for name, src in pairs(self.musicQueue) do
        self.music[name] = love.audio.newSource(src)
        self.musicQueue[name] = nil
    end

    for name, src in pairs(self.imageQueue) do
        self.images[name] = love.graphics.newImage(src)
        self.imageQueue[name] = nil
    end

end