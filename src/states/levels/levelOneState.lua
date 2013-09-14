LevelOneState = class("LevelOneState", LevelState)

function LevelOneState:load()
    self.__super.load(self)

    -- Playercreation
    playercutie = CutieModel(0, 0, resources.images.cutie1, 100)
    playercutie:addComponent(IsPlayer())
    playercutie:getComponent("PhysicsComponent").body:setPosition(333, 520)
    self.engine:addEntity(playercutie)

    -- Wall creation
    local wall =  Entity()
    wall:addComponent(DrawablePolygonComponent(world, 500, 580, 1050, 10, "static", wall))
    self.engine:addEntity(wall)

    wall =  Entity()
    wall:addComponent(DrawablePolygonComponent(world, 500, -50, 1050, 0, "static", wall))
    self.engine:addEntity(wall)

    for i = 0, 4, 1 do 
        local y = 100 + 100 * i
        local xbreite = 200 + 100 * i 
        wall = Entity()
        wall:addComponent(DrawablePolygonComponent(world, 500, y, xbreite, 10, "static", wall))
        self.engine:addEntity(wall)
    end

    for i = 0, 1, 1 do
        local x = 20 + i * 960
        wall = Entity()
        wall:addComponent(DrawablePolygonComponent(world, x, 200, 10, 200, "static", wall))
        self.engine:addEntity(wall)
    end

    -- Background
    self.bg = Entity()
    self.bg:addComponent(DrawableComponent(resources.images.level1, 0, 1, 1, 0, 0))
    self.bg:addComponent(PositionComponent(0, 0))
    self.bg:addComponent(ZIndex(0))
    self.engine:addEntity(self.bg)
end
