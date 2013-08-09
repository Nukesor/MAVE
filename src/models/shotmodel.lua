ShotModel = class("ShotModel", Entity)

function ShotModel:__init(x, y, xt, yt)
    
    
    
    local akat, gkat
    akat = xt - x
    gkat = yt - y

    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local sin = gkat/hypo
    local cos = akat/hypo

    local body = love.physics.newBody(world, x+(30*cos), y+(30*sin), "dynamic")
    local shape = love.physics.newRectangleShape(10, 1) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
        body:setMass(0)
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent())
    self:addComponent(DrawableComponent(resources.images.shot, math.atan2(akat, -gkat)-math.pi/2, 1, 1, 5, 5))
    self:addComponent(IsShot())
    self:addComponent(ZIndex(99))
    self:addComponent(DamageComponent(20))

    body:setGravityScale(0.1)
    body:setLinearVelocity((1000*cos), (1000*sin))
    print(body:getLinearVelocity())
end