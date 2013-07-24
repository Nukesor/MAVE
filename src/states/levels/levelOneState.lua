LevelOneState = class("LevelOneState", LevelState)

function LevelOneState:load()
    self.__super.load(self)

    self.bg:addComponent(DrawableComponent(resources.images.level1, 0, 1, 1, 0, 0))
end
