LevelOneState = class("LevelOneState", LevelState)

function LevelOneState:load()
    self.__super.load(self)

    -- Playercutie Position
    playercutie:getComponent("PhysicsComponent").body:setPosition(333, 520)

    -- Wall creation
    local wall =  Entity()
    wall:addComponent(DrawablePolygonComponent(world, 960, 1080* (29/30), 1970, 1080/60, "static", wall))
    self.engine:addEntity(wall)

    wall =  Entity()
    wall:addComponent(DrawablePolygonComponent(world, 960, -50, 1970, 1080/60, "static", wall))
    self.engine:addEntity(wall)

    for i = 0, 4, 1 do 
        local y = 1080/6 * (i+1)
        local xbreite = 1920/10 * (i+2) 
        wall = Entity()
        wall:addComponent(DrawablePolygonComponent(world, 960, y, xbreite, 10, "static", wall))
        self.engine:addEntity(wall)
    end

    for i = 0, 1, 1 do
        local x = 1920/25 + i * 1920 * (23/25)
        wall = Entity()
        wall:addComponent(DrawablePolygonComponent(world, x, 1080/3, 10, 1080/3, "static", wall))
        self.engine:addEntity(wall)
    end

    --[[
    -- Background picture
    self.bg = Entity()
    self.bg:addComponent(DrawableComponent(resources.images.background, 0, 1, 1, 0, 0))
    self.bg:addComponent(PositionComponent(0, 0))
    self.bg:addComponent(ZIndex(0))
    self.engine:addEntity(self.bg)
    --]]
end
