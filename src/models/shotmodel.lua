ShotModel = class("ShotModel", Entity)

function ShotModel:__init(x, y, xt, yt)
    local akat, gkat
    akat = xt - x
    gkat = yt - y

    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local sin = gkat/hypo
    local cos = akat/hypo

    local body = love.physics.newBody(world, x+(80 * cos * relation()), y+(80 * sin * relation()), "dynamic")
    local shape = love.physics.newRectangleShape(50 * relation(), 8 * relation()) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
        body:setMass(0)
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent(x,y))
    self:addComponent(DrawableComponent(resources.images.shot, math.atan2(akat, -gkat)-math.pi/2, 1, 1, 20, 4))
    self:addComponent(IsShot())
    self:addComponent(ZIndex(99))
    self:addComponent(DamageComponent(20))
    self:addComponent(TimerComponent(1.5))

    body:setGravityScale(0.1)
    body:setAngle(math.atan2(akat, -gkat)-math.pi/2)
    body:setLinearVelocity((2000*cos*relation()), (2000*sin*relation()))
end