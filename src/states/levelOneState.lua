print("hello")
LevelOneState = class("LevelOneState", LevelState)

function LevelOneState:load()
    self.__super.load(self)

    -- Add the level Background
    print("adding background")
    self.bg = Entity()
    self.bg:addComponent(DrawableComponent(resources.images.level1, 0, 1, 1, 0, 0))
    self.bg:addComponent(PositionComponent(0, 0))
    self.bg:addComponent(ZIndex(1))
    self.engine:addEntity(self.bg)
end
