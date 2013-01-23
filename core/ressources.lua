

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

function ressources:load()

end