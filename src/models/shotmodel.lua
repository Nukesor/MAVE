ShotModel = class("ShotModel", Entity)

function ShotModel:initialize(x, y, damage, speed, xt, yt)
    local sin, cos = getSinCos(x, y, xt, yt)

    local body = love.physics.newBody(world, x+(80 * cos * relation()), y+(80 * sin * relation()), "dynamic")
    local shape = love.physics.newRectangleShape(50 * relation(), 8 * relation()) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
        body:setMass(0)
    fixture:setFilterData(5, 3, -1)
        
    self:add(PhysicsComponent(body, fixture, shape ))
    self:add(PositionComponent(x,y))
    self:add(DrawableComponent(resources.images.shot, getRadian(x, y, xt, yt), 1, 1, 20, 4))
    self:add(IsShot())
    self:add(ZIndex(99))
    self:add(DamageComponent(damage))
    self:add(TimerComponent(1.5))

    body:setGravityScale(0.1)
    body:setAngle(getRadian(x, y, xt, yt))
    body:setLinearVelocity((speed*cos*relation()), (speed*sin*relation()))
end