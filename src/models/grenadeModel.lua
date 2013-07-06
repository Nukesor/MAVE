GrenadeModel = class("GrenadeModel", Entity)

function GrenadeModel:__init(x, y, xt, yt)
    
    local akat, gkat
        akat = xt - x
        gkat = yt - y

    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local cos = gkat/hypo
    local sin = akat/hypo

    local body = love.physics.newBody(world, x+20*sin, y+20*cos, "dynamic")
    local shape = love.physics.newCircleShape(6) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(0.5)  
        body:setMass(1)
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent())
    self:addComponent(DrawableComponent(resources.images.grenade, 0, 0.08, 0.08, 100, 130))
    self:addComponent(IsGrenade())
    self:addComponent(ExplosionComponent(40, 170))
    self:addComponent(TimerComponent(1.5))
    self:addComponent(ZIndex(99))

    body:setLinearVelocity((300 * sin), (300 * cos))
end