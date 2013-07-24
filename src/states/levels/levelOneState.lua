LevelOneState = class("LevelOneState", LevelState)

function LevelOneState:load()
    self.__super.load(self)

    playercutie:getComponent("PhysicsComponent").body:setPosition(333, 520)

    -- Wall creation
    self.wall =  Entity()
    self.wall:addComponent(DrawablePolygonComponent(world, 500, 580, 1050, 10, "static", self.wall))
    self.engine:addEntity(self.wall)

    self.wall =  Entity()
    self.wall:addComponent(DrawablePolygonComponent(world, 500, -50, 1050, 0, "static", self.wall))
    self.engine:addEntity(self.wall)

    for i = 0, 4, 1 do 
        local y = 100 + 100 * i
        local xbreite = 200 + 100 * i 
        self.wall = Entity()
        self.wall:addComponent(DrawablePolygonComponent(world, 500, y, xbreite, 10, "static", self.wall))
        self.engine:addEntity(self.wall)
    end

    for i = 0, 1, 1 do
        local x = 20 + i * 960
        self.wall = Entity()
        self.wall:addComponent(DrawablePolygonComponent(world, x, 200, 10, 200, "static", self.wall))
        self.engine:addEntity(self.wall)
    end

    -- Background
    self.bg:addComponent(DrawableComponent(resources.images.level1, 0, 1, 1, 0, 0))
end
