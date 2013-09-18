LevelOneState = class("LevelOneState", LevelState)

function LevelOneState:load()
    self.__super.load(self)

    -- Playercutie Position
    playercutie:getComponent("PhysicsComponent").body:setPosition(333, 520)

    -- Wall creation
    local wall =  Entity()
    wall:addComponent(DrawablePolygonComponent(world, love.graphics.getWidth()/2, love.graphics.getHeight()* (29/30), love.graphics.getWidth()+50, love.graphics.getHeight()/60, "static", wall))
    self.engine:addEntity(wall)

    wall =  Entity()
    wall:addComponent(DrawablePolygonComponent(world, love.graphics.getWidth()/2, -50, love.graphics.getWidth()+50, love.graphics.getHeight()/60, "static", wall))
    self.engine:addEntity(wall)

    for i = 0, 4, 1 do 
        local y = love.graphics.getHeight()/6 * (i+1)
        local xbreite = love.graphics.getWidth()/10 * (i+2) 
        wall = Entity()
        wall:addComponent(DrawablePolygonComponent(world, love.graphics.getWidth()/2, y, xbreite, 10, "static", wall))
        self.engine:addEntity(wall)
    end

    for i = 0, 1, 1 do
        local x = love.graphics.getWidth()/25 + i * love.graphics.getWidth() * (24/25)
        wall = Entity()
        wall:addComponent(DrawablePolygonComponent(world, x, love.graphics.getHeight()/3, 10, love.graphics.getHeight()/3, "static", wall))
        self.engine:addEntity(wall)
    end

    -- Background
    self.bg = Entity()
    self.bg:addComponent(DrawableComponent(resources.images.background, 0, relation(), relation(), 0, 0))
    self.bg:addComponent(PositionComponent(0, 0))
    self.bg:addComponent(ZIndex(0))
    self.engine:addEntity(self.bg)
end
