require("core/helper")

Resources = class("Resources")

function Resources:__init()
    
	self.imageQueue = {}
    self.musicQueue = {}
    self.fontQueue= {}

	self.images = {}
    self.music = {}
    self.fonts = {}
end

function Resources:addImage(name, src)
    self.imageQueue[name] = src
end

function Resources:addMusic(name, src)
    self.musicQueue[name] = src
end

function Resources:addFont(name, src, size)
    self.fontQueue[name] = {src, size}
end

function Resources:load(threaded)

    for name, pair in pairs(self.fontQueue) do
        self.fonts[name] = love.graphics.newFont(src)
        self.fontQueue[name] = nil
    end
    for name, src in pairs(self.musicQueue) do
        self.music[name] = love.audio.newSource(src)
        self.musicQueue[name] = nil
    end

    for name, src in pairs(self.imageQueue) do
        self.images[name] = love.graphics.newImage(src)
        self.imageQueue[name] = nil
    end

end