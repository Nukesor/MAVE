

Resources = {}

function Resources:setup()
    
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
        self.music[name] = love.audio.newSource(self.prefix .. src)
        self.musicQueue[name] = nil
    end

    for name, src in pairs(self.imageQueue) do
        self.images[name] = love.graphics.newImage(self.prefix .. src)
        self.imageQueue[name] = nil
    end

end