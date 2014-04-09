MineModel = class("MineModel", Entity)


function MineModel:__init(x,y)
    local direction
    if love.mouse.getX() < x then
        direction = -30 * relation()
    else
        direction = 30 * relation()
    end
    local body = love.physics.newBody(world, x+direction, y+(20 * relation()), "dynamic")
    local shape = love.physics.newRectangleShape(30* relation(), 20* relation()) 
    local fixture = love.physics.newFixture(body, shape, 0)  
    fixture:setRestitution(0.5)
    fixture:setFilterData(7, 5, 3)
    body:setMass(1)

    self:add(PhysicsComponent(body, fixture, shape ))
    self:add(PositionComponent(x, y))
    self:add(DrawableComponent(resources.images.mine, 0, 0.3, 0.3, 0, 0))
    self:add(ExplosionComponent(100, 250*relation()))
    self:add(ProximityExplodeComponent(60))
    self:add(ZIndex(99))
end