GrenadeModel = class("GrenadeModel", Entity)

function GrenadeModel:__init(x, y, xt, yt)

    self.__super.__init(self)
    local body = love.physics.newBody(world, x, y, "dynamic")
    local shape = love.physics.newCircleShape(1) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(0.5)  
        body:setMass(1)
    self:addComponent(DamageComponent(100))
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent())
    self:addComponent(DrawableComponent(resources.images.shot, 0, 1, 1, 5, 5))
    self:addComponent(IsGrenade())
    self:addComponent(ExplosionComponent(40, 200))
    self:addComponent(TimerComponent(2))
    self:addComponent(ZIndex(99))
    
    local akat, gkat
        akat = xt - x
        gkat = yt - y

    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local cos = gkat/hypo
    local sin = akat/hypo
    body:setLinearVelocity((300 * sin), (300 * cos))
end