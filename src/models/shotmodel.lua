ShotModel = class("ShotModel", Entity)

function ShotModel:__init(x, y, damage, speed, xt, yt)
    local sin, cos = getSinCos(x, y, xt, yt)

    local body = love.physics.newBody(world, x+(80 * cos * relation()), y+(80 * sin * relation()), "dynamic")
    local shape = love.physics.newRectangleShape(50 * relation(), 8 * relation()) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
        body:setMass(0)
    fixture:setFilterData(5, 3, -1)
        
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent(x,y))
    self:addComponent(DrawableComponent(resources.images.shot, getRadian(x, y, xt, yt), 1, 1, 20, 4))
    self:addComponent(IsShot())
    self:addComponent(ZIndex(99))
    self:addComponent(DamageComponent(damage))
    self:addComponent(TimerComponent(1.5))

    body:setGravityScale(0.1)
    body:setAngle(getRadian(x, y, xt, yt))
    body:setLinearVelocity((speed*cos*relation()), (speed*sin*relation()))
end