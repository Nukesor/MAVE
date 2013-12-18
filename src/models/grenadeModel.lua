GrenadeModel = class("GrenadeModel", Entity)

function GrenadeModel:__init(x, y, xt, yt)
    
    local sin, cos = getSinCos(x, y, xt, yt)

    local body = love.physics.newBody(world, x+20*sin, y+20*cos, "dynamic")
    local shape = love.physics.newCircleShape(6) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(0.5)  
        body:setMass(1)
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent(x,y))
    self:addComponent(DrawableComponent(resources.images.grenade, 0, 0.14, 0.14, 100, 130))
    self:addComponent(IsGrenade())
    self:addComponent(ExplosionComponent(80, 240*relation()))
    self:addComponent(TimerComponent(1.5))
    self:addComponent(ZIndex(99))

    body:setLinearVelocity((300 * cos), (300 * sin))
end