LevelTwoState = class("LevelTwoState", LevelState)

function LevelTwoState:load()
    self.__super.load(self)

    self.bg:add(DrawableComponent(resources.images.level2, 0, 1, 1, 0, 0))
end