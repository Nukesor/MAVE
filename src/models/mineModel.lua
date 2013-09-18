MineModel = class("MineModel", Entity)


function MineModel:__init(x,y)
    local direction
    if love.mouse.getX() < x then
        direction = -30 * relation()
    else
        direction = 30 * relation()
    end
    local body = love.physics.newBody(world, x+direction, y+(20 * relation()), "dynamic")
    local shape = love.physics.newRectangleShape(10* relation(), 8* relation()) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(0.5)  
        body:setMass(1)
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent(x, y))
    self:addComponent(DrawableComponent(resources.images.mine, 0, 0.2 * relation(), 0.2 *relation(), 100, 130))
    self:addComponent(ExplosionComponent(100 * relation(), 250 * relation()))
    self:addComponent(ProximityExplodeComponent(60 * relation()))
    self:addComponent(ZIndex(99))
end