MineModel = class("MineModel", Entity)


function MineModel:__init(x,y)

    local body = love.physics.newBody(world, x, y, "dynamic")
    local shape = love.physics.newRectangleShape(10, 10) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(0.5)  
        body:setMass(1)
    self:addComponent(PhysicsComponent(body, fixture, shape ))
	self:addComponent(PositionComponent(x,y))
    self:addComponent(DrawableComponent(resources.images.grenade, 0, 0.08, 0.08, 100, 130))
    self:addComponent(IsMine())
    self:addComponent(ExplosionComponent(40, 120))
    self:addComponent(ZIndex(99))
end