GrenadeModel = class("GrenadeModel", Entity)

function GrenadeModel:initialize(x, y, xt, yt)
    
    local sin, cos = getSinCos(x, y, xt, yt)

    local body = love.physics.newBody(world, x+20*sin, y+20*cos, "dynamic")
    local shape = love.physics.newCircleShape(6) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(0.5)  
        body:setMass(1)
    self:add(PhysicsComponent(body, fixture, shape ))
    self:add(PositionComponent(x,y))
    self:add(DrawableComponent(resources.images.grenade, 0, 0.14, 0.14, 100, 130))
    self:add(IsGrenade())
    self:add(ExplosionComponent(50, 240*relation()))
    self:add(TimerComponent(1.5))
    self:add(ZIndex(99))

    body:setLinearVelocity((300 * cos), (300 * sin))
end