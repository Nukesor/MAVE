require("core/helper")

ShotModel = class("ShotModel", Entity)

function ShotModel:__init(x, y, xt, yt)
    
    self.components = {}
    local body = love.physics.newBody(world, x, y, "dynamic")
    local shape = love.physics.newCircleShape(3) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
        body:setMass(0)
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent())
    self:addComponent(DrawableComponent(resources.images.shot, 0, 1, 1, 5, 5))
    self:addComponent(ZIndex(99))
    local akat, gkat
    if math.abs(xt-x) < 500 then
        akat = xt - x
        gkat = yt - y
    elseif ((xt - x) > 500) then
        akat = -(x - xt + 1000)
        gkat = yt - y
    elseif ((xt - x) < -500) then
        akat = xt - x + 1000
        gkat = yt - y
    end
    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local cos = gkat/hypo
    local sin = akat/hypo
    body:setLinearVelocity((800 * sin), (800 * cos))
end