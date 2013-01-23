

ressources = {}

function ressources:__init()

	self.imageQueue = {}
    self.musicQueue = {}

	self.images = {}
    self.music = {}

function Resources:addImage(name, src)
    self.imageQueue[name] = src
end

function Resources:addMusic(name, src)
    self.musicQueue[name] = src
end

function ressources:load(threaded)

    for name, src in pairs(self.musicQueue) do
        self.music[name] = love.audio.newSource(self.prefix .. src)
        self.musicQueue[name] = nil
    end

    for name, src in pairs(self.imageQueue) do
        self.images[name] = love.graphics.newImage(self.prefix .. src)
        self.imageQueue[name] = nil
    end

end